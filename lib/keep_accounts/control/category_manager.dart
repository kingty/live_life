import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/category_data.dart';

class CategoryManager {
  CategoryManager._();

  factory CategoryManager() {
    return instance;
  }

  static  CategoryManager instance = CategoryManager._();

  static List<CategoryData> incomeCategories = List.empty();
  static List<CategoryData> outcomeCategories = List.empty();

  Future<bool> fetchCategories() async {
    String jsonStr =
        await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var outcomeJson = userMap['outcome'];

    incomeCategories = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    outcomeCategories = List<CategoryData>.from(
        outcomeJson.map((model) => CategoryData.fromJson(model)));

    return true;
  }
}
