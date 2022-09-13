import 'package:live_life/keep_accounts/db/data_provider.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'package:rxdart/rxdart.dart';

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
}

class TransactionMiddleWare {
  final BehaviorSubject<List<TransactionData>> _latestTransactions =
      BehaviorSubject();

  final TransactionProvider _provider = TransactionProvider();

  Future<void> saveTransaction(TransactionData transactionData) async {
    await _provider.insertOrUpdate(transactionData);
    _fetchLatestTransactions();
  }

  Stream<List<TransactionData>> getLatestTransactionsStream() {
    _fetchLatestTransactions();
    return _latestTransactions.stream;
  }

  _fetchLatestTransactions() async {
    DateTime lastWeek =
        getDate(DateTime.now()).subtract(const Duration(days: 7));
    var result = await _provider.pullTransactionsByFilter(start: lastWeek);
    _latestTransactions.add(result);
  }

  Future<List<TransactionData>> fetchTransactionsByDay(DateTime day,
      {int? categoryId, String? tagId}) async {
    var start = getDate(day);
    final end = getDate(DateTime.now()).add(const Duration(days: 1));
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }

  Future<List<TransactionData>> fetchTransactionsByMonth(DateTime day,
      {int? categoryId, String? tagId}) async {
    final start = DateTime.utc(day.year, day.month, 1);
    final end = DateTime.utc(day.year, day.month + 1, 1);
    var result = await _provider.pullTransactionsByFilter(
        start: start, end: end, categoryId: categoryId, tagId: tagId);
    return result;
  }

  Future<List<TransactionData>> fetchTransactionsByYear(DateTime day,
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
  final BehaviorSubject<List<AccountData>> _accounts = BehaviorSubject();
  final AccountProvider _provider = AccountProvider();
  bool _initAccounts = false;

  Stream<List<AccountData>> getAccountsStream() {
    if (!_initAccounts) {
      _initAccounts = true;
      _fetchAllAccountsAndNotify();
    }
    return _accounts.stream;
  }

  _fetchAllAccountsAndNotify() async {
    var result = await _provider.pullAllAccounts();
    _accounts.add(result);
  }

  Future<void> saveAccount(AccountData accountData) async {
    await _provider.insertOrUpdate(accountData);
    _fetchAllAccountsAndNotify();
  }

  Future<void> deleteAccount(AccountData accountData) async {
    await _provider.delete(accountData);
    _fetchAllAccountsAndNotify();
  }
}
