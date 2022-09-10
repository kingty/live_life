import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';
import 'db.dart';

class AccountProvider extends Provider {
  Future<List<AccountData>> pullAllAccounts() async {
    var maps = await _db.query(tableAccountData);
    if (maps.isNotEmpty) {
      return maps.map((e) => AccountData().fromMap(e)).toList();
    }
    return List.empty();
  }
}

class Provider<T extends TableData> {
  final DB _db = DB.instance;

  Future<T> insertOrUpdate(T data) async {
    bool isExist = await _db.isExistPrimaryKey(data);
    if (isExist) {
      await _db.update(data);
    } else {
      await _db.insert(data);
    }
    return data;
  }

  Future<void> delete(T data) async {
    await _db.delete(data);
  }
}
