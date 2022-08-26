import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/category_data.dart';

class CategoryManager {
  CategoryManager._();

  factory CategoryManager() {
    return instance;
  }

  static CategoryManager instance = CategoryManager._();

  static List<CategoryData> incomeCategories = List.empty();
  static List<CategoryData> expenseCategories = List.empty();
  Map<int, CategoryData> categoriesMap = <int, CategoryData>{};

  void init() {
    fetchCategories().ignore();
  }

  CategoryData? getById(int id) {
    return categoriesMap[id];
  }

  Future<bool> fetchCategories() async {
    String jsonStr =
        await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var expenseJson = userMap['expense'];

    incomeCategories = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    expenseCategories = List<CategoryData>.from(
        expenseJson.map((model) => CategoryData.fromJson(model)));

    CategoryManager.incomeCategories
        .where((element) => element.id != 10)
        .forEach((element) {
      categoriesMap[element.id] = element;
      if (element.children.isNotEmpty) {
        for (var child in element.children) {
          categoriesMap[child.id] = child;
        }
      }
    });
    CategoryManager.expenseCategories
        .where((element) => element.id != 10)
        .forEach((element) {
      categoriesMap[element.id] = element;
      if (element.children.isNotEmpty) {
        for (var child in element.children) {
          categoriesMap[child.id] = child;
        }
      }
    });
    return true;
  }
}
