import 'package:live_life/keep_accounts/db/data_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../models/account_data.dart';

class MiddleWare {
  MiddleWare._();

  factory MiddleWare() {
    return instance;
  }

  static MiddleWare instance = MiddleWare._();
  final AccountMiddleWare account = AccountMiddleWare();
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
