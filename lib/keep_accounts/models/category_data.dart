import 'dart:ffi';

class CategoryData {
  CategoryData(
      {this.id = 0,
      this.pId = 0,
      this.name = '',
      this.iconPath = '',
      this.priority = 0});

  int id;
  int pId;
  String name;
  String iconPath;
  int priority;


}
