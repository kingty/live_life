// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_life/keep_accounts/models/category_data.dart';

import 'package:live_life/main.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    String jsonStr =
        await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var outcomeJson = userMap['outcome'];

    List<CategoryData> income = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    List<CategoryData> outcome = List<CategoryData>.from(
        outcomeJson.map((model) => CategoryData.fromJson(model)));

    outcome.forEach((element) {
      print(element.name);
      print(element.children.length);
      if (element.children.isNotEmpty) {
        element.children.forEach((child) {
          print(child.name);
        });
      }
    });
  });
}
