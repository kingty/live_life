import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../control/middle_ware.dart';
import '../../models/transaction_data.dart';

class StatisticsCategoryExpenseView extends StatelessWidget {
  StatisticsCategoryExpenseView({Key? key, required this.mode})
      : super(key: key);
  final DateRangePickerView mode;

  final List<CircleChartData> _chartData = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_getAspectRatio(), Text("1")],
    );
  }

  Widget _getAspectRatio() {
    return StreamBuilder<List<TransactionData>>(
        stream:
            MiddleWare.instance.transaction.getStatisticsTransactionsStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionData>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SizedBox(
                height: 240,
                child: SfCircularChart(
                  series: _getEmptyDoughnutSeries(),
                ));
          } else {
            return SizedBox(
                height: 240,
                child: SfCircularChart(
                  series: _getDoughnutSeries(
                      CircleChartData.dealFromSources(snapshot.data!)),
                  // tooltipBehavior: _tooltip,
                ));
          }
        });
  }

  List<DoughnutSeries<CircleChartData, String>> _getDoughnutSeries(
      List<CircleChartData> datas) {
    return <DoughnutSeries<CircleChartData, String>>[
      DoughnutSeries<CircleChartData, String>(
          radius: '95%',
          innerRadius: '70%',
          dataSource: datas,
          xValueMapper: (CircleChartData data, _) => data.categoryData.name,
          yValueMapper: (CircleChartData data, _) => data.amount,
          pointColorMapper: (CircleChartData data, _) =>
              data.categoryData.color,
          dataLabelMapper: (CircleChartData data, _) => data.categoryData.name,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              textStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: KeepAccountsTheme.nearlyWhite,
                  fontSize: 10)))
    ];
  }

  List<DoughnutSeries<CircleChartData, String>> _getEmptyDoughnutSeries() {
    return <DoughnutSeries<CircleChartData, String>>[
      DoughnutSeries<CircleChartData, String>(
          radius: '95%',
          innerRadius: '70%',
          dataSource: [
            CircleChartData(),
          ],
          xValueMapper: (CircleChartData data, _) => '',
          yValueMapper: (CircleChartData data, _) => 100,
          pointColorMapper: (CircleChartData data, _) => Colors.grey,
          dataLabelMapper: (CircleChartData data, _) => '',
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }
}
