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
  static List<CategoryData> specialCategories = List.empty();
  Map<int, CategoryData> categoriesMap = <int, CategoryData>{};
  static bool _isInit = false;

  static const int SPECIAL_RENT_IN = 3001;
  static const int SPECIAL_RENT_OUT = 3002;
  static const int SPECIAL_FINANCE = 3003;
  static const int SPECIAL_TRANSFER = 3004;

  void init() {
    fetchCategories().ignore();
  }

  CategoryData? getById(int id) {
    return categoriesMap[id];
  }

  Future<bool> fetchCategories() async {
    if (_isInit) return true;
    String jsonStr =
        await rootBundle.loadString('assets/keep_accounts/category.json');
    Map<String, dynamic> userMap = json.decode(jsonStr);
    var incomeJson = userMap['income'];
    var expenseJson = userMap['expense'];
    var financeJson = userMap['finance'];

    incomeCategories = List<CategoryData>.from(
        incomeJson.map((model) => CategoryData.fromJson(model)));
    expenseCategories = List<CategoryData>.from(
        expenseJson.map((model) => CategoryData.fromJson(model)));
    specialCategories = List<CategoryData>.from(
        financeJson.map((model) => CategoryData.fromJson(model)));

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
    CategoryManager.specialCategories
        .where((element) => element.id != 10)
        .forEach((element) {
      categoriesMap[element.id] = element;
      if (element.children.isNotEmpty) {
        for (var child in element.children) {
          categoriesMap[child.id] = child;
        }
      }
    });
    _isInit = true;
    return true;
  }
}
