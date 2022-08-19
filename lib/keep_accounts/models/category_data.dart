import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:live_life/icons/custom_icons.dart';

class CategoryData {
  CategoryData(
      {this.id = 0, this.name = '', this.icon = '', this.priority = 0});

  int id;
  String name;
  int priority = 0;
  String icon;
  List<CategoryData> children = <CategoryData>[];

  CategoryData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'],
        priority = json['priority'],
        children = json['children'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'id': id,
        'children': children,
        'priority': priority,
      };

  // static CategoryData bank = CategoryData(0, '饮食', "test");

  ///GenerateCodeStart
  static List<CategoryData> banks = <CategoryData>[
    CategoryData(id: 0, name: '饮食', icon: "test"),
    CategoryData(id: 1, name: 'asd', icon: "test"),
  ];

  static List<CategoryData> banks2 = <CategoryData>[
    CategoryData(id: 2, name: 'sdcsc', icon: "test"),
    CategoryData(id: 3, name: 'cdsgvbdf', icon: "test"),
  ];

  void encode() {}

  ///GenerateCodeEnd

}
