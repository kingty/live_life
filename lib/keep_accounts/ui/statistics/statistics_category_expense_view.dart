import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../icons/custom_icons.dart';
import '../../../main.dart';
import '../../control/middle_ware.dart';
import '../../models/transaction_data.dart';
import '../ui_view/category_icon_view.dart';

class StatisticsCategoryExpenseView extends StatelessWidget {
  StatisticsCategoryExpenseView({Key? key, required this.mode})
      : super(key: key);
  final DateRangePickerView mode;

  @override
  Widget build(BuildContext context) {
    return _getWidget();
  }

  Widget _getWidget() {
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
            List<CircleChartData> chartData =
                CircleChartData.dealFromSources(snapshot.data!)
                    .where((element) => element.categoryData.isExpense())
                    .toList();
            chartData.sort((a, b) {
              return b.amount.compareTo(a.amount);
            });
            return ListView.builder(
              itemCount: chartData.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(
                      height: 240,
                      child: SfCircularChart(
                        series: _getDoughnutSeries(chartData),
                        // tooltipBehavior: _tooltip,
                      ));
                } else {
                  return StatisticsCategoryItemView(
                    data: chartData[index - 1],
                  );
                }
              },
            );
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
                  fontSize: 8)))
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

class StatisticsCategoryItemView extends StatelessWidget {
  StatisticsCategoryItemView({Key? key, required this.data}) : super(key: key);
  final CircleChartData data;

  @override
  Widget build(BuildContext context) {
    var category = data.categoryData;
    var color = data.categoryData.color;
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          CategoryIconView(
            size: 15,
            iconData: CustomIcons.customIcons[category.icon] ?? Icons.image,
            color: color,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: KeepAccountsTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.1,
                      color: KeepAccountsTheme.nearlyBlack.withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    height: 4,
                    width: 120,
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: (120 * 0.5),
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              category.color.withOpacity(0.4),
                              category.color,
                            ]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 6,
              ),
              Text(
                "¥ ${category.isExpense() ? "-" : "+"}${data.amount.toString()}",
                style: const TextStyle(
                  fontFamily: KeepAccountsTheme.fontName,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.1,
                  color: KeepAccountsTheme.darkRed,
                ),
              ),
              Text(
                '共支出${data.transactions.length}笔',
                style: KeepAccountsTheme.smallDetail,
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.keyboard_arrow_right_sharp,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
