import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/record_transaction/expense_input_view.dart';
import 'package:live_life/keep_accounts/record_transaction/transfer_input_view.dart';

import '../../common_view/tabbar/custom_tab_indicator.dart';
import '../../common_view/tabbar/custom_tabs.dart';
import 'income_input_view.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            color: KeepAccountsTheme.nearlyDarkBlue.withOpacity(0.7),
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
    var colors = [
      KeepAccountsTheme.pink.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      KeepAccountsTheme.nearlyDarkBlue.withOpacity(0.7)
    ];
    return CustomTabBar(
        indicator: MagicTabIndicator(
            labelColors: colors, pageController: tabController),
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
      ExpenseInputView(),
      IncomeInputView(),
      TransferInputView()
    ]);
  }
}
