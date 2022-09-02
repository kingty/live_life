import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.categories.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          var element = widget.categories[index];
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = index;
                  widget.onSelectCategory?.call(element.id);
                });
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
                                  CustomIcons.customIcons[element.icon]!)),
                      Visibility(
                          visible: element.children.isNotEmpty,
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
                    element.name,
                    style: KeepAccountsTheme.caption,
                  )
                ],
              ));
        });
  }
}
