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

  Future<int> insert(TableData data) async {
    final builder = SqlBuilder.insert(data.getTableName(), data.toMap());
    int count = 0;
    await _database?.transaction((txn) async {
      count = await txn.insert(data.getTableName(), data.toMap());
      processWriteSql(builder, txn);
    });
    return count;
  }

  Future<int> update(TableData data) async {
    final builder = SqlBuilder.update(data.getTableName(), data.toMap(),
        where: data.getPrimaryKey(), whereArgs: [data.id]);
    int count = 0;
    await _database?.transaction((txn) async {
      count = await txn.update(data.getTableName(), data.toMap(),
          where: data.getPrimaryKey(), whereArgs: [data.id]);
      processWriteSql(builder, txn);
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

  void processWriteSql(SqlBuilder builder, Transaction txn) {
    var log = LogData()
      ..sql = builder.sql
      ..args = _serializeArgs(builder.arguments);

    print(log.sql);
    print(log.args);

    txn.insert(tableLogData, log.toMap());
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
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $tableLogData (id INTEGER PRIMARY KEY, $cSql TEXT, $cArgs TEXT);');
      var sqlAccount = '''CREATE TABLE IF NOT EXISTS $tableAccountData (
          $cId TEXT PRIMARY KEY, 
          $cAccountBankDataKey TEXT, 
          $cAccountName TEXT, 
          $cAccountDes TEXT, 
          $cAccountCash REAL,
          $cAccountFinancial REAL,
          $cAccountDebt REAL,
          $cAccountLend REAL);''';
      db.execute(sqlAccount);

      var sqlTag = '''CREATE TABLE IF NOT EXISTS $tableTagData (
          $cId TEXT PRIMARY KEY, 
          $cTagName TEXT, 
          $cTagDes TEXT);''';
      db.execute(sqlTag);

      var sqlTransaction = '''CREATE TABLE IF NOT EXISTS $tableTransactionData (
          $cId TEXT PRIMARY KEY, 
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
          $cTransactionEndTime INTEGER);''';
      db.execute(sqlTransaction);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {});
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
