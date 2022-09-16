import 'package:flutter/material.dart';
import 'package:live_life/common_view/dot_line_border.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../control/middle_ware.dart';
import '../../models/ui_data.dart';

class StatisticsOverviewView extends StatisticsBaseAnimatorView {
  const StatisticsOverviewView(
      {Key? key,
      required super.animationController,
      required super.index,
      required super.mode})
      : super(key: key);

  @override
  Widget buildInnerWidget() {
    return StreamBuilder<StatisticsViewData>(
        stream:
            MiddleWare.instance.transaction.getStatisticsTransactionsStream(),
        builder:
            (BuildContext context, AsyncSnapshot<StatisticsViewData> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return _buildDisplayWidget(snapshot.data!);
          }
        });
  }

  @override
  Widget _buildDisplayWidget(StatisticsViewData data) {
    var borderColor = Colors.black12.withOpacity(0.03);
    var isYearMode = mode == DateRangePickerView.decade;
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
                  child: Row(
                    children: [
                      Text(isYearMode ? "年度收支预览" : "月度收支预览"),
                      const Spacer(),
                      // const Icon(
                      //   Icons.keyboard_arrow_right,
                      // )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: borderColor, width: 1)),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isYearMode ? "本年结余" : "本月结余",
                            style: KeepAccountsTheme.caption,
                          ),
                          Text(
                            "¥ ${data.sumBalance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: KeepAccountsTheme.nearlyDarkBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isYearMode ? "本年收入" : "本月收入",
                            style: KeepAccountsTheme.caption,
                          ),
                          Text(
                            "¥ ${data.sumIncome.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: KeepAccountsTheme.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Text(isYearMode ? "本年支出" : "本月支出",
                              style: KeepAccountsTheme.caption),
                          Text(
                            "¥ ${data.sumExpense.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: KeepAccountsTheme.darkRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]))
                  ])),
            ],
          ),
        ));
  }
}
