import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/category_data.dart';

class CategoryManager {
  static List<CategoryData> incomeCategories = List.empty();
  static List<CategoryData> outcomeCategories = List.empty();

  Future<void> fetchCategories() async {
    String jsonStr =
        await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var outcomeJson = userMap['outcome'];

    List<CategoryData> income = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    List<CategoryData> outcome = List<CategoryData>.from(
        outcomeJson.map((model) => CategoryData.fromJson(model)));
  }
}
