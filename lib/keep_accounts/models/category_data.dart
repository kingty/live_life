import 'package:flutter/material.dart';

import '../../helper.dart';

class CategoryData {
  CategoryData(
      {this.id = 0,
      this.name = '',
      this.icon = '',
      this.priority = 0,
      this.color = Colors.black});

  int id;
  String name;
  int priority = 0;
  String icon;
  Color color;
  List<CategoryData> children = <CategoryData>[];

  int getRootId() {
    if (id < 10000) {
      return id;
    } else {
      return id ~/ 1000;
    }
  }

  bool isExpense() {
    return id.toString().startsWith("1");
  }

  bool isIncome() {
    return id.toString().startsWith("2");
  }

  bool isSpecial() {
    return id > 3000;
  }

  CategoryData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'],
        priority = (json['priority'] == null) ? 0 : json['priority'],
        children = (json['children'] == null)
            ? <CategoryData>[]
            : List<dynamic>.from(json['children'])
                .map((i) => CategoryData.fromJson(i))
                .toList(),
        color = hexToColor(json['color']),
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'id': id,
        'children': children,
        'priority': priority,
      };
}
