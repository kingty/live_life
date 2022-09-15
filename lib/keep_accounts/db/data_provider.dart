import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'db.dart';

class TransactionProvider extends Provider {
  //获取所有账单
  Future<List<TransactionData>> pullAllTransactions() async {
    var maps = await _db.query(tableTransactionData);
    if (maps.isNotEmpty) {
      return maps.map((e) => TransactionData().fromMap(e)).toList();
    }
    return List.empty();
  }

  ///start : xx日期以来
  ///end   : xx日期之前
  ///categoryId : 类型
  ///tagId : 标签
  Future<List<TransactionData>> pullTransactionsByFilter({
    DateTime? start,
    DateTime? end,
    int? categoryId,
    String? tagId,
  }) async {
    List<String> where = List.empty(growable: true);
    List<Object> whereArgs = List.empty(growable: true);
    where.add('$cIsDelete != 1');
    if (start != null && end != null && start.isAfter(end)) {
      throw Exception('start should not after end!!!');
    }
    if (start != null) {
      where.add('$cTransactionTranTime > ?');
      whereArgs.add(start.millisecondsSinceEpoch);
    }
    if (end != null) {
      where.add('$cTransactionTranTime < ?');
      whereArgs.add(end.millisecondsSinceEpoch);
    }
    if (categoryId != null) {
      where.add('$cTransactionCategoryId = ?');
      whereArgs.add(categoryId);
    }
    if (tagId != null) {
      where.add('$cTransactionTagId = ?');
      whereArgs.add(tagId);
    }

    var maps = await _db.query(tableTransactionData,
        where: where.join(' AND '), whereArgs: whereArgs);
    if (maps.isNotEmpty) {
      return maps.map((e) => TransactionData().fromMap(e)).toList();
    }
    return List.empty();
  }
}

class AccountProvider extends Provider {
  Future<AccountData> getDefaultAccount() async {
    var maps =
        await _db.query(tableAccountData, where: "$cId = '$defaultAccountId'");
    if (maps.isNotEmpty) {
      return maps.map((e) => AccountData().fromMap(e)).toList().first;
    } else {
      throw Exception('there should be a defaultAccount!');
    }
  }

  Future<List<AccountData>> pullAllAccounts() async {
    var maps = await _db.query(tableAccountData, where: '$cIsDelete != 1');
    if (maps.isNotEmpty) {
      return maps.map((e) => AccountData().fromMap(e)).toList();
    }
    return List.empty();
  }
}

class TagProvider extends Provider {
  Future<List<TagData>> pullAllTags() async {
    var maps = await _db.query(tableTagData, where: '$cIsDelete != 1');
    if (maps.isNotEmpty) {
      return maps.map((e) => TagData().fromMap(e)).toList();
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
