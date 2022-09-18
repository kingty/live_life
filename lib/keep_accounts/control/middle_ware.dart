import 'package:live_life/keep_accounts/db/data_provider.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../helper.dart';
import '../models/account_data.dart';
import '../models/ui_data.dart';
import 'category_manager.dart';

class MiddleWare {
  MiddleWare._();

  factory MiddleWare() {
    return instance;
  }

  double budget = 5000;
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
  final BehaviorSubject<StatisticsViewData> _statisticsTransactions =
      BehaviorSubject();

  final TransactionProvider _provider = TransactionProvider();

  Future<void> saveTransaction(TransactionData transactionData) async {
    double amountDiff = 0;
    await _provider.transaction((txn) async {
      TransactionData? old =
          await _provider.txnGetOldTransaction(txn, transactionData);
      if (old != null) {
        //存在
        await _provider.txnUpdate(txn, transactionData);
        amountDiff = transactionData.amount - old.amount;
      } else {
        await _provider.txnInsert(txn, transactionData);
        amountDiff = transactionData.amount;
      }
      if (amountDiff != 0) {
        if (transactionData.isSpecial() &&
            transactionData.categoryId == CategoryManager.SPECIAL_TRANSFER) {
          //转账，处理两个账户

          AccountData inAccountData = MiddleWare.instance.account
              .getAccountById(transactionData.inAccountId)
              .copy();
          AccountData outAccountData = MiddleWare.instance.account
              .getAccountById(transactionData.outAccountId)
              .copy();
          if (!inAccountData.isDefaultAccount()) {
            inAccountData.cash = inAccountData.cash + amountDiff;
            await _provider.txnUpdate(txn, inAccountData);
          }
          if (!outAccountData.isDefaultAccount()) {
            outAccountData.cash = outAccountData.cash - amountDiff;
            await _provider.txnUpdate(txn, outAccountData);
          }
        } else {
          String? accountId = transactionData.getRealAccountId();
          if (accountId == null) {
            throw Exception('accountId should not null here');
          }
          AccountData accountData =
              MiddleWare.instance.account.getAccountById(accountId).copy();
          //如果是默认账户，或者删除了的账户直接跳过
          if (!accountData.isDefaultAccount()) {
            if (transactionData.isSpecial()) {
              if (transactionData.categoryId ==
                  CategoryManager.SPECIAL_RENT_IN) {
                accountData.debt = accountData.debt + amountDiff;
                accountData.cash = accountData.cash + amountDiff;
              } else if (transactionData.categoryId ==
                  CategoryManager.SPECIAL_RENT_OUT) {
                accountData.lend = accountData.lend + amountDiff;
                accountData.cash = accountData.cash - amountDiff;
              } else if (transactionData.categoryId ==
                  CategoryManager.SPECIAL_FINANCE) {
                //理财，更新两项
                accountData.financial = accountData.financial + amountDiff;
                accountData.cash = accountData.cash - amountDiff;
              }
            } else {
              if (transactionData.isExpense()) {
                accountData.cash = accountData.cash - amountDiff;
              } else {
                accountData.cash = accountData.cash + amountDiff;
              }
            }
            await _provider.txnUpdate(txn, accountData);
          }
        }
      }
    });

    //notify other collection
    if (amountDiff != 0) {
      MiddleWare.instance.account.fetchAllAccountsAndNotify();
    }
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

  Stream<StatisticsViewData> getStatisticsTransactionsStream() {
    return _statisticsTransactions.stream;
  }

  void flashStatisticsTransactionsStream() {
    _statisticsTransactions.add(StatisticsViewData.empty());
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
    _statisticsTransactions.add(StatisticsViewData(ts));
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
    final start = DateTime(day.year, day.month, 1);
    final end = DateTime(day.year, day.month + 1, 1);
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }

  Future<List<TransactionData>> _fetchTransactionsByYear(DateTime day,
      {int? categoryId, String? tagId}) async {
    final start = DateTime(day.year, 1, 1);
    final end = DateTime(day.year + 1, 1, 1);
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }
}

class TagMiddleWare {
  final BehaviorSubject<List<TagData>> _tags = BehaviorSubject();
  final TagProvider _provider = TagProvider();
  bool _initTags = false;
  final Map<String, TagData> _tagMap = {};

  Stream<List<TagData>> getTagsStream() {
    if (!_initTags) {
      _initTags = true;
      _fetchAllTagsAndNotify();
    }
    return _tags.stream;
  }

  _fetchAllTagsAndNotify() async {
    var result = await _provider.pullAllTags();
    _tagMap.clear();
    for (var element in result) {
      _tagMap[element.id] = element;
    }

    _tags.add(result);
  }

  TagData? getTagById(String id) {
    if (_tagMap.containsKey(id)) {
      return _tagMap[id]!;
    } else {
      // 删除了的tag，返回null
      return null;
    }
  }

  Future<void> saveTag(TagData tagData) async {
    await _provider.insertOrUpdate(tagData);
    _fetchAllTagsAndNotify();
  }

  Future<void> deleteTag(TagData tagData) async {
    await _provider.delete(tagData);
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

  AccountData getAccountById(String id) {
    if (_accountMap.containsKey(id)) {
      return _accountMap[id]!;
    } else {
      // 删除了的account，对应的transaction，直接为defaultAccount
      return defaultAccount;
    }
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
