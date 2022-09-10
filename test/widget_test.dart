// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_life/keep_accounts/db/db.dart';
import 'package:live_life/keep_accounts/db/sql_builder.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/category_data.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';
import 'package:live_life/keep_accounts/models/mock_data.dart';
import 'package:live_life/keep_accounts/ui/ui_view/transaction_list_view.dart';

import 'package:live_life/main.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    String jsonStr =
    await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var expenseJson = userMap['expense'];

    List<CategoryData> income = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    List<CategoryData> expense = List<CategoryData>.from(
        expenseJson.map((model) => CategoryData.fromJson(model)));

    expense.forEach((element) {
      print(element.name);
      print(element.children.length);
      if (element.children.isNotEmpty) {
        element.children.forEach((child) {
          print(child.name);
        });
      }
    });
  });

  testWidgets('test mock ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var trans = await MockData.getTransactions();

    // trans.forEach((element) {
    //   print(element.categoryId);
    // });

    var sections = MonthSection.getMonthSections(trans);

    for (var s in sections) {
      print(
          "${s.month}-${s.items.map((e) => e.transactionData.recordTime)
              .toList()
              .join("_")}");
    }
  });

  testWidgets('test builder ', (WidgetTester tester) async {
    var accounts = MockData.getAccounts();
    // var builder = SqlBuilder.query(
    //   tableAccountData,
    //   columns: null, // null=all
    //   where: '$cId=?',
    //   whereArgs: [accounts.first.id],
    // );
    //
    // var builder2 = SqlBuilder.update(tableAccountData, accounts.first.toMap(),
    //     where: '$cId=?', whereArgs: [accounts.first.id]);
    //
    // var builder3 = SqlBuilder.insert(tableAccountData, accounts.first.toMap());
    //
    // print(builder.sql);
    // print(builder.arguments);
    // print(builder2.sql);
    // print(builder2.arguments);
    // print(builder3.sql);
    // print(builder3.arguments);
    //
    // var serializeArgs = DB.instance.serializeArgs(builder3.arguments);
    // print(serializeArgs);
    //
    // var list = json.decode(serializeArgs) as List;
    // print (json.encode(list));

  });
}
