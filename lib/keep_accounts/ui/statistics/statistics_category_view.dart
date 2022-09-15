import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_category_expense_view.dart';
import '../../../common_view/tabbar/custom_tab_indicator.dart';
import '../../../common_view/tabbar/custom_tabs.dart';
import '../../../helper.dart';
import '../../control/middle_ware.dart';
import '../../models/transaction_data.dart';

class StatisticsCategoryView extends StatisticsBaseAnimatorStatefulView {
  const StatisticsCategoryView(
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
  final random = Random();
  late double _height;
  List<Pair<double, Widget>> tabviews = List.empty(growable: true);

  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    _height = 200;
    _tabController =
        TabController(length: 3, vsync: this, animationDuration: _duration);
    _tabController.addListener(() {
      setState(() {
        _height = tabviews[_tabController.index].first;
      });
    });

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
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text("收支统计"),
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
          CustomTab(text: "其他"),
        ]);
  }

  Widget _getTabBarPages() {
    return AnimatedContainer(
        duration: _duration,
        curve: Curves.fastOutSlowIn,
        height: _height,
        child: StreamBuilder<List<TransactionData>>(
            stream: MiddleWare.instance.transaction
                .getStatisticsTransactionsStream(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TransactionData>> snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox();
              } else {
                List<CircleChartData> all =
                    CircleChartData.dealFromSources(snapshot.data!);

                final List<CircleChartData> chartDataExpense = all
                    .where((element) => element.categoryData.isExpense())
                    .toList();
                tabviews.clear();
                tabviews.add(Pair(
                    chartDataExpense.length * 50 + 250,
                    StatisticsCategoryExpenseView(
                      type: 0,
                      mode: widget.mode,
                      chartData: chartDataExpense,
                    )));
                final List<CircleChartData> chartDataIncome = all
                    .where((element) => element.categoryData.isIncome())
                    .toList();
                tabviews.add(Pair(
                    chartDataIncome.length * 50 + 250,
                    StatisticsCategoryExpenseView(
                      type: 1,
                      mode: widget.mode,
                      chartData: chartDataIncome,
                    )));

                final List<CircleChartData> chartDataSpecial = all
                    .where((element) => element.categoryData.isSpecial())
                    .toList();
                tabviews.add(Pair(
                    chartDataSpecial.length * 50 + 250,
                    StatisticsCategoryExpenseView(
                      type: 2,
                      mode: widget.mode,
                      chartData: chartDataSpecial,
                    )));
                _height = chartDataExpense.length * 50 + 250;

                return TabBarView(
                    controller: _tabController,
                    children: tabviews.map((e) => e.second).toList());
              }
            }));
  }
}
