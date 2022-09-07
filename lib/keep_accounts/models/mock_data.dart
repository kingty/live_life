import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';

import '../../common_view/list/src/sliver_expandable_list.dart';
import '../control/category_manager.dart';
import 'category_data.dart';

///
/// create some example data.
///
class MockData {
  ///return a example list, by default, we have 4 sections,
  ///each section has 5 items.
  static List<ExampleSection> getExampleSections(
      [int sectionSize = 10, int itemSize = 5]) {
    var sections = List<ExampleSection>.empty(growable: true);
    for (int i = 0; i < sectionSize; i++) {
      var section = ExampleSection()
        ..header = "Header#$i"
        ..items = List.generate(itemSize, (index) => "ListTile #$index")
        ..expanded = i == 0 ? false : true;
      sections.add(section);
    }
    return sections;
  }

  static List<AccountData> getAccounts() {
    int i = 1000;
    return BankData.gydxsyyh.values
        .map((value) => AccountData()
          ..id = (i++).toString()
          ..des = "des"
          ..cash = 23.3
          ..financial = 34.2
          ..name = value.name
          ..bankDataKey = value.key)
        .toList();
  }

  static List<TagData> getTags() {
    int i = 0;
    return BankData.gydxsyyh.values
        .map((value) => TagData()
          ..id = (i++).toString()
          ..des = "des"
          ..name = value.name)
        .toList();
  }

  static Future<List<TransactionData>> getTransactions() async {
    String jsonStr = await rootBundle
        .loadString('assets/keep_accounts/mock-transacitons.json');
    Iterable trans = json.decode(jsonStr);
    List<TransactionData> list = List<TransactionData>.from(
        trans.map((model) => TransactionData.fromJson(model)));

    await CategoryManager.instance.fetchCategories();
    List<CategoryData> all = List.empty(growable: true);
    CategoryManager.incomeCategories
        .where((element) => element.id != 10)
        .forEach((element) {
      all.add(element);
      if (element.children.isNotEmpty) {
        for (var child in element.children) {
          all.add(child);
        }
      }
    });
    CategoryManager.expenseCategories
        .where((element) => element.id != 10)
        .forEach((element) {
      all.add(element);
      if (element.children.isNotEmpty) {
        for (var child in element.children) {
          all.add(child);
        }
      }
    });
    var size = all.length;
    //= all.elementAt(e.categoryId % size).id
    for (var e in list) {
      e.categoryId = all.elementAt(e.categoryId % size).id;
    }
    return list;
  }
}

///Section model example
///
///Section model must implements ExpandableListSection<T>, each section has
///expand state, sublist. "T" is the model of each item in the sublist.
class ExampleSection implements ExpandableListSection<String> {
  //store expand state.
  late bool expanded;

  //return item model list.
  late List<String> items;

  //example header, optional
  late String header;

  @override
  List<String> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}
