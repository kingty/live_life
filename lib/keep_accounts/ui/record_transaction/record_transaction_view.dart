import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/category_manager.dart';
import 'package:live_life/keep_accounts/ui/record_transaction/transaction_input_view.dart';
import '../../../common_view/tabbar/custom_tab_indicator.dart';
import '../../../common_view/tabbar/custom_tabs.dart';
import '../keep_accounts_them.dart';

class RecordTransactionView extends StatefulWidget {
  const RecordTransactionView({Key? key}) : super(key: key);

  @override
  _RecordTransactionViewState createState() => _RecordTransactionViewState();
}

class _RecordTransactionViewState extends State<RecordTransactionView>
    with TickerProviderStateMixin {
  late TabController tabController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      focusNode.unfocus();
    });
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
            color: KeepAccountsTheme.nearlyDarkBlue,
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
      KeepAccountsTheme.darkRed,
      Colors.green,
      KeepAccountsTheme.nearlyDarkBlue
    ];
    return CustomTabBar(
        indicator: MagicTabIndicator(
            labelColors: colors, pageController: tabController),
        labelColors: colors,
        unselectedLabelColor: Colors.grey,
        controller: tabController,
        tabs: const [
          CustomTab(text: "支出"),
          CustomTab(text: "收入"),
          CustomTab(text: "其他"),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      TransactionInputView(
        focusNode: focusNode,
        mainColor: KeepAccountsTheme.darkRed,
        type: 0,
      ),
      TransactionInputView(
        focusNode: focusNode,
        mainColor: KeepAccountsTheme.green,
        type: 1,
      ),
      TransactionInputView(
        focusNode: focusNode,
        mainColor: KeepAccountsTheme.nearlyDarkBlue,
        type: 2,
      )
    ]);
  }
}
