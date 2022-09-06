import 'package:flutter/material.dart';

import '../../helper.dart';
import '../../icons/custom_icons.dart';
import '../keep_accounts_them.dart';
import '../models/category_data.dart';
import '../ui_view/category_icon_view.dart';

class CategorySelectView extends StatefulWidget {
  const CategorySelectView(
      {super.key,
      required this.categories,
      this.onSelectCategory,
      required this.color});

  @override
  _CategorySelectViewState createState() => _CategorySelectViewState();
  final List<CategoryData> categories;
  final ValueChanged<int>? onSelectCategory;
  final Color color;
}

class _CategorySelectViewState extends State<CategorySelectView>
    with TickerProviderStateMixin {
  int selectIndex = -1;
  int selectSecondIndex = -1;
  int crossAxisCount = 5;

  @override
  void initState() {
    crossAxisCount =
        widget.categories.length > 5 ? 5 : widget.categories.length;
    super.initState();
  }

  Widget getChildrenCategories(
      List<CategoryData> categories, ValueChanged<int>? onSelectCategory) {
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        var categoryItem = categories[index];
        return InkWell(
            onTap: () {
              Navigator.pop(context);
              onSelectCategory?.call(categoryItem.id);
              setState(() {
                selectSecondIndex = index;
              });
            },
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: (selectSecondIndex == index)
                  ? BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    )
                  : null,
              margin: const EdgeInsets.only(left: 14, right: 14),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: Row(
                children: [
                  CategoryIconView(
                    iconData: CustomIcons.customIcons[categoryItem.icon] ??
                        Icons.image,
                    color: widget.color,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      categoryItem.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: KeepAccountsTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: -0.1,
                        color: KeepAccountsTheme.nearlyBlack.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.black12.withOpacity(0.05),
          indent: 12,
          endIndent: 12,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount),
        itemBuilder: (context, index) {
          CategoryData parent = widget.categories[index];
          CategoryData categoryShow;
          if (selectSecondIndex >= 0 && selectIndex == index) {
            categoryShow = widget.categories[index].children[selectSecondIndex];
          } else {
            categoryShow = widget.categories[index];
          }

          return GestureDetector(
              onTap: () {
                setState(() {
                  if (index != selectIndex) {
                    selectSecondIndex = -1;
                  }
                  selectIndex = index;
                });
                if (parent.children.isNotEmpty) {
                  showBottomSheetPanel(
                      context,
                      SizedBox(
                          height: 400,
                          child: getChildrenCategories(
                              parent.children, widget.onSelectCategory)));
                } else {
                  widget.onSelectCategory?.call(categoryShow.id);
                }
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(7),
                          child: CategoryIconView(
                              index: index,
                              selectIndex: selectIndex,
                              color: widget.color,
                              iconData:
                                  CustomIcons.customIcons[categoryShow.icon]!)),
                      Visibility(
                          visible: parent.children.isNotEmpty,
                          child: Positioned(
                            left: 40,
                            top: 40,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: selectIndex == index
                                  ? widget.color
                                  : Colors.grey,
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Text(
                    parent.name +
                        ((parent == categoryShow)
                            ? ""
                            : "-${categoryShow.name.substring(0, 2)}"),
                    style: KeepAccountsTheme.caption,
                  )
                ],
              ));
        });
  }
}
