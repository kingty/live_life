import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/category_manager.dart';
import 'package:live_life/keep_accounts/ui/record_transaction/transaction_input_view.dart';
import '../../../common_view/tabbar/custom_tab_indicator.dart';
import '../../../common_view/tabbar/custom_tabs.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';

class RecordTransactionView extends StatefulWidget {
  const RecordTransactionView({Key? key, this.transactionData})
      : super(key: key);
  final TransactionData? transactionData;

  @override
  _RecordTransactionViewState createState() => _RecordTransactionViewState();
}

class _RecordTransactionViewState extends State<RecordTransactionView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
  int _theIndex = -1;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _focusNode.unfocus();
    });
    if (widget.transactionData != null) {
      if (widget.transactionData!.isExpense()) {
        _theIndex = 0;
      } else if (widget.transactionData!.isIncome()) {
        _theIndex = 1;
      } else if (widget.transactionData!.isSpecial()) {
        _theIndex = 2;
      }
      _tabController.index = _theIndex;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        onTap: (index) {
          if (widget.transactionData != null) {
            _tabController.index = _theIndex;
          }
        },
        indicator: MagicTabIndicator(
            labelColors: colors, pageController: _tabController),
        labelColors: colors,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: const [
          CustomTab(text: "支出"),
          CustomTab(text: "收入"),
          CustomTab(text: "其他"),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(
        physics: widget.transactionData != null
            ? const NeverScrollableScrollPhysics()
            : null,
        controller: _tabController,
        children: <Widget>[
          TransactionInputView(
            transactionData: _theIndex == 0 ? widget.transactionData : null,
            focusNode: _focusNode,
            mainColor: KeepAccountsTheme.darkRed,
            type: 0,
          ),
          TransactionInputView(
            transactionData: _theIndex == 1 ? widget.transactionData : null,
            focusNode: _focusNode,
            mainColor: KeepAccountsTheme.green,
            type: 1,
          ),
          TransactionInputView(
            transactionData: _theIndex == 2 ? widget.transactionData : null,
            focusNode: _focusNode,
            mainColor: KeepAccountsTheme.nearlyDarkBlue,
            type: 2,
          )
        ]);
  }
}
