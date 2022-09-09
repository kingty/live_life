import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:live_life/keep_accounts/control/sql_builder.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<int> insert(String table, Map<String, Object?> values) async {
    final builder = SqlBuilder.insert(table, values);
    int count = 0;
    await _database?.transaction((txn) async {
      count = await _database!.insert(table, values);
      processWriteSql(builder);
    });
    return count;
  }

  Future<int> update(String table, Map<String, Object?> values,
      {String? where, List<Object?>? whereArgs}) async {
    final builder =
        SqlBuilder.update(table, values, where: where, whereArgs: whereArgs);
    int count = 0;
    await _database?.transaction((txn) async {
      count = await _database!
          .update(table, values, where: where, whereArgs: whereArgs);
      processWriteSql(builder);
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

  void processWriteSql(SqlBuilder builder) {
    var log = LogData()
      ..sql = builder.sql
      ..args = _serializeArgs(builder.arguments);
    _database?.insert(tableLogData, log.toMap());
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
    String path = '${databasesPath}keep_account.db';

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $tableLogData (id INTEGER PRIMARY KEY, $cSql TEXT, $cArgs TEXT)');
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
