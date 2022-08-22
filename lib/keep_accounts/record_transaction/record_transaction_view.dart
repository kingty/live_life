import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/common_view/custom_tabs.dart';
import 'package:live_life/keep_accounts/keep_accounts_them.dart';

import '../../common_view/custom_tab_indicator.dart';

class RecordTransactionView extends StatefulWidget {
  @override
  _RecordTransactionViewState createState() => _RecordTransactionViewState();
}

class _RecordTransactionViewState extends State<RecordTransactionView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            color: KeepAccountsTheme.purple,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: KeepAccountsTheme.nearlyWhite,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: getTabBar(),
            ),
          ),
        ),
        body: getTabBarPages());
  }

  Widget getTabBar() {
    var colors = [KeepAccountsTheme.pink, Colors.green, KeepAccountsTheme.purple];
    return CustomTabBar(
        indicator: MagicTabIndicator(labelColors: colors, pageController: tabController),
        labelColors: colors,
        unselectedLabelColor: Colors.grey,
        controller: tabController,
        tabs: [
          CustomTab(text: "支出"),
          CustomTab(text: "收入"),
          CustomTab(text: "转账"),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(color: KeepAccountsTheme.background),
      Container(color: KeepAccountsTheme.background),
      Container(color: KeepAccountsTheme.background)
    ]);
  }
}
