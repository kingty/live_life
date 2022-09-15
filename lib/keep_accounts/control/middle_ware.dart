import 'package:live_life/keep_accounts/db/data_provider.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../helper.dart';
import '../models/account_data.dart';

class MiddleWare {
  MiddleWare._();

  factory MiddleWare() {
    return instance;
  }

  static MiddleWare instance = MiddleWare._();
  final AccountMiddleWare account = AccountMiddleWare();
  final TransactionMiddleWare transaction = TransactionMiddleWare();
  final TagMiddleWare tag = TagMiddleWare();

  Future<void> init() async {
    await account.getDefaultAccount();
    await account.fetchAllAccountsAndNotify();
    transaction.fetchCurrentMonthTransactions();
  }
}

class TransactionMiddleWare {
  final BehaviorSubject<List<TransactionData>> _currentMonthTransactions =
      BehaviorSubject();

  final BehaviorSubject<List<TransactionData>> _latestTransactions =
      BehaviorSubject();

  final BehaviorSubject<List<TransactionData>> _calenderTransactions =
      BehaviorSubject();
  final BehaviorSubject<List<TransactionData>> _statisticsTransactions =
      BehaviorSubject();

  final TransactionProvider _provider = TransactionProvider();

  Future<void> saveTransaction(TransactionData transactionData) async {
    await _provider.insertOrUpdate(transactionData);
    _fetchLatestTransactions();
    if (_statisticsTransactions.hasListener && _lastStatisticsMode != null) {
      fetchTransactionsForStatistics(_lastStatisticsMode!, _lastStatisticsDay!);
    }
    fetchCurrentMonthTransactions();
  }

  Stream<List<TransactionData>> getLatestTransactionsStream() {
    _fetchLatestTransactions();
    return _latestTransactions.stream;
  }

  Stream<List<TransactionData>> getCurrentMonthTransactionsStream() {
    return _currentMonthTransactions.stream;
  }

  Stream<List<TransactionData>> getCalenderTransactionsStream() {
    return _calenderTransactions.stream;
  }

  void flashCalenderTransactionsStream() {
    _calenderTransactions.add(List.empty());
  }

  Stream<List<TransactionData>> getStatisticsTransactionsStream() {
    return _statisticsTransactions.stream;
  }

  void flashStatisticsTransactionsStream() {
    _statisticsTransactions.add(List.empty());
  }

  _fetchLatestTransactions() async {
    DateTime lastWeek =
        getDateBegin(DateTime.now()).subtract(const Duration(days: 7));
    var result = await _provider.pullTransactionsByFilter(start: lastWeek);
    _latestTransactions.add(result);
  }

  fetchCurrentMonthTransactions() async {
    var result = await _fetchTransactionsByMonth(DateTime.now());
    _currentMonthTransactions.add(result);
  }

  DateRangePickerView? _lastStatisticsMode;
  DateTime? _lastStatisticsDay;

  Future<void> fetchTransactionsForStatistics(
    DateRangePickerView mode,
    DateTime day,
  ) async {
    _lastStatisticsMode = mode;
    _lastStatisticsDay = day;
    List<TransactionData> ts = List.empty();
    if (mode == DateRangePickerView.year) {
      ts = await _fetchTransactionsByMonth(day);
    }
    if (mode == DateRangePickerView.decade) {
      ts = await _fetchTransactionsByYear(day);
    }
    _statisticsTransactions.add(ts);
  }

  Future<void> fetchTransactionsForCalender(
    DateRangePickerView mode,
    DateTime day,
  ) async {
    List<TransactionData> ts = List.empty();
    if (mode == DateRangePickerView.month) {
      ts = await _fetchTransactionsByMonth(day);
    }
    if (mode == DateRangePickerView.year) {
      ts = await _fetchTransactionsByMonth(day);
    }
    if (mode == DateRangePickerView.decade) {
      ts = await _fetchTransactionsByYear(day);
    }
    _calenderTransactions.add(ts);
  }

  Future<List<TransactionData>> _fetchTransactionsByDay(DateTime day,
      {int? categoryId, String? tagId}) async {
    var start = getDateBegin(day);
    final end = getDateBegin(DateTime.now()).add(const Duration(days: 1));
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }

  Future<List<TransactionData>> _fetchTransactionsByMonth(DateTime day,
      {int? categoryId, String? tagId}) async {
    final start = DateTime.utc(day.year, day.month, 1);
    final end = DateTime.utc(day.year, day.month + 1, 1);
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }

  Future<List<TransactionData>> _fetchTransactionsByYear(DateTime day,
      {int? categoryId, String? tagId}) async {
    final start = DateTime.utc(day.year, 1, 1);
    final end = DateTime.utc(day.year + 1, 1, 1);
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }
}

class TagMiddleWare {
  final BehaviorSubject<List<TagData>> _tags = BehaviorSubject();
  final TagProvider _provider = TagProvider();
  bool _initTags = false;

  Stream<List<TagData>> getTagsStream() {
    if (!_initTags) {
      _initTags = true;
      _fetchAllTagsAndNotify();
    }
    return _tags.stream;
  }

  Future<void> saveAccount(TagData tagData) async {
    await _provider.insertOrUpdate(tagData);
    _fetchAllTagsAndNotify();
  }

  _fetchAllTagsAndNotify() async {
    var result = await _provider.pullAllTags();
    _tags.add(result);
  }

  Future<void> saveTag(TagData accountData) async {
    await _provider.insertOrUpdate(accountData);
    _fetchAllTagsAndNotify();
  }

  Future<void> deleteAccount(TagData accountData) async {
    await _provider.delete(accountData);
    _fetchAllTagsAndNotify();
  }
}

class AccountMiddleWare {
  late AccountData defaultAccount;
  final BehaviorSubject<List<AccountData>> _accounts = BehaviorSubject();
  final AccountProvider _provider = AccountProvider();
  bool _initAccounts = false;
  final Map<String, AccountData> _accountMap = {};

  Future<void> getDefaultAccount() async {
    defaultAccount = await _provider.getDefaultAccount();
  }

  Stream<List<AccountData>> getAccountsStream() {
    if (!_initAccounts) {
      _initAccounts = true;
      fetchAllAccountsAndNotify();
    }
    return _accounts.stream;
  }

  AccountData? getAccountById(String id) {
    return _accountMap[id];
  }

  Future<void> fetchAllAccountsAndNotify() async {
    var result = await _provider.pullAllAccounts();
    _accountMap.clear();
    for (var element in result) {
      _accountMap[element.id] = element;
    }
    _accounts.add(result);
  }

  Future<void> saveAccount(AccountData accountData) async {
    await _provider.insertOrUpdate(accountData);
    fetchAllAccountsAndNotify();
  }

  Future<void> deleteAccount(AccountData accountData) async {
    await _provider.delete(accountData);
    fetchAllAccountsAndNotify();
  }
}
