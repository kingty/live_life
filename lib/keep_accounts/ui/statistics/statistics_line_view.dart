import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_category_expense_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
                  child: _getLineChart()),
            ],
          ),
        ));
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<DayOverViewData, String>> _getDefaultSplineSeries(
      List<DayOverViewData> datas) {
    return <SplineSeries<DayOverViewData, String>>[
      SplineSeries<DayOverViewData, String>(
        dataSource: datas,
        xValueMapper: (DayOverViewData day, _) =>
            day.firstTransactionDate.day.toString(),
        yValueMapper: (DayOverViewData day, _) => day.countExpense,
        // markerSettings: const MarkerSettings(isVisible: true),
        name: '支出',
      ),
      SplineSeries<DayOverViewData, String>(
        dataSource: datas,
        name: '收入',
        // markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (DayOverViewData day, _) =>
            day.firstTransactionDate.day.toString(),
        yValueMapper: (DayOverViewData day, _) => day.countIncome,
      )
    ];
  }

  Widget _getLineChart() {
    return SizedBox(
        height: 300,
        child: StreamBuilder<StatisticsViewData>(
            stream: MiddleWare.instance.transaction
                .getStatisticsTransactionsStream(),
            builder: (BuildContext context,
                AsyncSnapshot<StatisticsViewData> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                //todo replace DateTime.now()
                List<DayOverViewData> getDayOverViewDatas =
                    DayOverViewData.getDayOverViewDatas(
                        DateTime.now(), snapshot.data!.transactions);
                double maxCount = 0;
                double maximum = 0;
                for (var element in getDayOverViewDatas) {
                  if (element.countIncome > maxCount ||
                      element.countExpense > maxCount) {
                    maxCount = max(element.countIncome, element.countExpense);
                  }
                }
                for (int i = 1; i* 500 <maxCount ; i++ ) {
                  maximum = 500 * (i+1);
                }

                return SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  title: ChartTitle(text: ''),
                  legend: Legend(isVisible: false),
                  primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      labelPlacement: LabelPlacement.onTicks),
                  primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: maximum,
                      axisLine: const AxisLine(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      labelFormat: '¥{value}',
                      majorTickLines: const MajorTickLines(size: 0)),
                  series: _getDefaultSplineSeries(getDayOverViewDatas),
                  tooltipBehavior: TooltipBehavior(enable: true),
                );
              }
            }));
  }
}
