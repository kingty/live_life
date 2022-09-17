import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:live_life/keep_accounts/db/sql_builder.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/log_data.dart';

class DB {
  DB._();

  factory DB() {
    return instance;
  }

  static DB instance = DB._();
  Database? _database;

  closeDb() {
    _database?.close();
  }

  Future<bool> isExistPrimaryKey(TableData data) async {
    List<Map> maps = await _database!.query(
      data.getTableName(),
      columns: null, // null=all
      where: '${data.getPrimaryKey()} = ?',
      whereArgs: [data.id],
    );
    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /// fake delete row
  Future<int> delete(TableData data) async {
    int count = 0;
    await _database?.transaction((txn) async {
      String sql =
          'UPDATE ${data.getTableName()} SET ${data.getIsDeleteKey()} = 1 WHERE ${data.getPrimaryKey()} = ?';
      count = await txn.rawUpdate(sql, [data.id]);

      var log = LogData()
        ..sql = sql
        ..args = _serializeArgs([data.id]);
      txn.insert(tableLogData, log.toMap());
    });
    return count;
  }

  Future<int> txnInsert(Transaction txn, TableData data) async {
    final builder = SqlBuilder.insert(data.getTableName(), data.toMap());
    int count = await txn.insert(data.getTableName(), data.toMap());
    await processWriteSql(builder, txn);
    return count;
  }

  Future<int> txnUpdate(Transaction txn, TableData data) async {
    final builder = SqlBuilder.update(data.getTableName(), data.toMap(),
        where: '${data.getPrimaryKey()} = ?', whereArgs: [data.id]);
    int count = await txn.update(data.getTableName(), data.toMap(),
        where: '${data.getPrimaryKey()} = ?', whereArgs: [data.id]);
    await processWriteSql(builder, txn);
    return count;
  }

  Future<int> insert(TableData data) async {
    final builder = SqlBuilder.insert(data.getTableName(), data.toMap());
    int count = 0;
    await _database?.transaction((txn) async {
      count = await txn.insert(data.getTableName(), data.toMap());
      await processWriteSql(builder, txn);
    });
    return count;
  }

  Future<void> transaction(
      Future<void> Function(Transaction txn) action) async {
    return _database?.transaction(action);
  }

  Future<int> update(TableData data) async {
    final builder = SqlBuilder.update(data.getTableName(), data.toMap(),
        where: '${data.getPrimaryKey()} = ?', whereArgs: [data.id]);
    int count = 0;
    await _database?.transaction((txn) async {
      count = await txn.update(data.getTableName(), data.toMap(),
          where: '${data.getPrimaryKey()} = ?', whereArgs: [data.id]);
      await processWriteSql(builder, txn);
    });
    return count;
  }

  Future<List<Map<String, Object?>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) {
    return _database!.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Future<void> processWriteSql(SqlBuilder builder, Transaction txn) async {
    var log = LogData()
      ..sql = builder.sql
      ..args = _serializeArgs(builder.arguments);

    if (kDebugMode) {
      print(log.sql);
      print(log.args);
    }
    await txn.insert(tableLogData, log.toMap());
  }

  String _serializeArgs(List<Object?>? arguments) {
    if (arguments == null) return '';
    return json.encode(arguments);
  }

  List<Object?>? _deSerializeArgs(String argStr) {
    if (argStr.isEmpty) return null;
    return json.decode(argStr) as List;
  }

  Future<void> createDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'keep_account.db');
    if (kDebugMode) {
      print(path);
    }
    // open the database
    Database database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $tableLogData (id INTEGER PRIMARY KEY, $cSql TEXT, $cArgs TEXT);');
      var sqlAccount = '''CREATE TABLE IF NOT EXISTS $tableAccountData (
          $cId TEXT PRIMARY KEY NOT NULL, 
          $cAccountBankDataKey TEXT, 
          $cAccountName TEXT, 
          $cAccountDes TEXT, 
          $cAccountCash REAL,
          $cAccountFinancial REAL,
          $cAccountDebt REAL,
          $cAccountLend REAL,
          $cIsDelete INTEGER NOT NULL DEFAULT 0);''';
      db.execute(sqlAccount);

      AccountData defaultAccount = AccountData()
        ..id = defaultAccountId
        ..bankDataKey = 'OTHERW'
        ..name = '默认账户'
        ..des = '不知道统计的账户，或者临时的账单记录使用';
      db.insert(defaultAccount.getTableName(), defaultAccount.toMap());

      var sqlTag = '''CREATE TABLE IF NOT EXISTS $tableTagData (
          $cId TEXT PRIMARY KEY NOT NULL, 
          $cTagName TEXT, 
          $cTagDes TEXT,
          $cIsDelete INTEGER NOT NULL DEFAULT 0);''';
      db.execute(sqlTag);

      var sqlTransaction = '''CREATE TABLE IF NOT EXISTS $tableTransactionData (
          $cId TEXT PRIMARY KEY NOT NULL, 
          $cTransactionCategoryId INTEGER, 
          $cTransactionOutAccountId TEXT, 
          $cTransactionInAccountId TEXT, 
          $cTransactionAmount REAL,
          $cTransactionNote TEXT,
          $cTransactionTagId TEXT,
          $cTransactionTranTime INTEGER,
          $cTransactionRecordTime INTEGER,
          $cTransactionInterest REAL,
          $cTransactionStartTime INTEGER,
          $cTransactionEndTime INTEGER,
          $cTransactionIsEnd INTEGER,
          $cIsDelete INTEGER NOT NULL DEFAULT 0);''';
      db.execute(sqlTransaction);
      //时间作为索引
      var index =
          '''CREATE INDEX $indexTransactionTime ON $tableTransactionData ($cTransactionTranTime);''';
      db.execute(index);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {
      if (oldVersion == 1) {
        var addColumnIsEnd =
            '''ALTER TABLE $tableTransactionData ADD COLUMN $cTransactionIsEnd INTEGER;''';
        db.execute(addColumnIsEnd);
      }
    });
    _database = database;
  }

  Future writeData(List<String> sqls) async {
    await _database?.transaction((txn) async {
      for (var sql in sqls) {
        txn.execute(sql);
      }
    });
  }
}
