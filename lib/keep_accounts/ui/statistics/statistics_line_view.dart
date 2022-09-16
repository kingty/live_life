import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_category_expense_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common_view/tabbar/custom_tab_indicator.dart';
import '../../../common_view/tabbar/custom_tabs.dart';
import '../../../helper.dart';
import '../../control/middle_ware.dart';
import '../../models/transaction_data.dart';
import '../../models/ui_data.dart';

class StatisticsLineView extends StatisticsBaseAnimatorStatefulView {
  const StatisticsLineView(
      {Key? key,
      required super.animationController,
      required super.index,
      required super.mode})
      : super(key: key);

  @override
  _StatisticsCategoryViewState createState() => _StatisticsCategoryViewState();
}

class _StatisticsCategoryViewState
    extends StatisticsBaseAnimatorStatefulViewState {
  late TabController _tabController;

  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, animationDuration: _duration);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildInnerWidget() {
    var borderColor = Colors.black12.withOpacity(0.03);
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 15, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: KeepAccountsTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: KeepAccountsTheme.grey.withOpacity(0.01),
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 5.0),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                    widget.mode == DateRangePickerView.year ? "每日统计" : "每月统计"),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: borderColor, width: 1)),
                  ),
                  child: _getContent()),
            ],
          ),
        ));
  }

  Widget _getContent() {
    return Column(
      children: [
        _getTabBar(),
        _getTabBarPages(),
      ],
    );
  }

  Widget _getTabBar() {
    var colors = [
      KeepAccountsTheme.darkRed,
      Colors.green,
      KeepAccountsTheme.nearlyDarkBlue
    ];
    return CustomTabBar(
        indicator: MagicTabIndicator(
            borderSide: const BorderSide(width: 6),
            width: 6,
            labelColors: colors,
            pageController: _tabController),
        labelColors: colors,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: const [
          CustomTab(text: "支出"),
          CustomTab(text: "收入"),
        ]);
  }

  Widget _getTabBarPages() {
    return Container(
        height: 300,
        child: StreamBuilder<StatisticsViewData>(
            stream: MiddleWare.instance.transaction
                .getStatisticsTransactionsStream(),
            builder: (BuildContext context,
                AsyncSnapshot<StatisticsViewData> snapshot) {
              if (!snapshot.hasData ) {
                return const SizedBox();
              } else {
                // List<DayOverViewData> getDayOverViewDatas =
                //     DayOverViewData.getDayOverViewDatas(snapshot.data!);

                return TabBarView(controller: _tabController, children: []);
              }
            }));
  }
}
