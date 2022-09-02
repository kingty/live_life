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
        priority = (json['priority'] == null) ? 0 : json['priority'],
        children = (json['children'] == null)
            ? <CategoryData>[]
            : List<dynamic>.from(json['children'])
                .map((i) => CategoryData.fromJson(i))
                .toList(),
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'id': id,
        'children': children,
        'priority': priority,
      };
}
