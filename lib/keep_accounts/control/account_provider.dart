import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class AccountProvider {
  DB db = DB.instance;

  Future<AccountData> insertOrUpdate(AccountData accountData) async {
    List<Map> maps = await db.query(
      tableAccountData,
      columns: null, // null=all
      where: '$cId=?',
      whereArgs: [accountData.id],
    );
    if (maps.isNotEmpty) {
      await db.update(tableAccountData, accountData.toMap(),
          where: '$cId=?', whereArgs: [accountData.id]);
    } else {
      await db.insert(tableAccountData, accountData.toMap());
    }

    return accountData;
  }
}
