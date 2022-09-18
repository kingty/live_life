import 'package:flutter/material.dart';

import '../../../helper.dart';
import '../../../icons/custom_icons.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';
import '../../models/category_data.dart';
import '../ui_view/category_icon_view.dart';

class CategorySelectView extends StatefulWidget {
  const CategorySelectView(
      {super.key,
      required this.categories,
      this.onSelectCategory,
      required this.color,
      this.editTransactionData});

  @override
  _CategorySelectViewState createState() => _CategorySelectViewState();
  final List<CategoryData> categories;
  final ValueChanged<int>? onSelectCategory;
  final Color color;
  final TransactionData? editTransactionData;
}

class _CategorySelectViewState extends State<CategorySelectView>
    with TickerProviderStateMixin {
  int _selectIndex = -1;
  int _selectSecondIndex = -1;
  int _crossAxisCount = 5;
  bool _canSelect = true;

  @override
  void initState() {
    if (widget.editTransactionData != null) {
      int i = 0;
      for (var rc in widget.categories) {
        if (rc.id == widget.editTransactionData!.categoryId) {
          _selectIndex = i;
        }

        if (rc.children.isNotEmpty) {
          int j = 0;
          for (var lc in rc.children) {
            if (lc.id == widget.editTransactionData!.categoryId) {
              _selectIndex = i;
              _selectSecondIndex = j;
            }
            j++;
          }
        }
        if (_selectIndex != -1) {
          break;
        }
        i++;
      }
      if (widget.editTransactionData!.isSpecial()) {
        _canSelect = false;
      }
    }
    _crossAxisCount =
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
                _selectSecondIndex = index;
              });
            },
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: (_selectSecondIndex == index)
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
                    color: categoryItem.color,
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
            crossAxisCount: _crossAxisCount),
        itemBuilder: (context, index) {
          CategoryData parent = widget.categories[index];
          CategoryData categoryShow;
          if (_selectSecondIndex >= 0 && _selectIndex == index) {
            categoryShow =
                widget.categories[index].children[_selectSecondIndex];
          } else {
            categoryShow = widget.categories[index];
          }

          return GestureDetector(
              onTap: () {
                if (!_canSelect) return;
                setState(() {
                  if (index != _selectIndex) {
                    _selectSecondIndex = -1;
                  }
                  _selectIndex = index;
                });
                if (parent.children.isNotEmpty) {
                  widget.onSelectCategory?.call(categoryShow.id);
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
                              selectIndex: _selectIndex,
                              color: categoryShow.color,
                              iconData:
                                  CustomIcons.customIcons[categoryShow.icon]!)),
                      Visibility(
                          visible: parent.children.isNotEmpty,
                          child: Positioned(
                            left: 40,
                            top: 40,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: _selectIndex == index
                                  ? categoryShow.color
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
