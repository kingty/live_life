import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.iconData = Icons.image,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData iconData;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: Icons.calendar_month_outlined,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.account_balance_wallet_outlined,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.bar_chart_outlined,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.settings_suggest_outlined,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
