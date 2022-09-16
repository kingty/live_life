import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StatisticsTimeSelectView extends StatisticsBaseAnimatorStatefulView {
  const StatisticsTimeSelectView(this.onSelectChange,
      {required super.animationController,
      required super.index,
      required super.mode});

  final ValueChanged<DateTime>? onSelectChange;

  @override
  _StatisticsTimeSelectViewState createState() =>
      _StatisticsTimeSelectViewState();
}

class _StatisticsTimeSelectViewState
    extends StatisticsBaseAnimatorStatefulViewState<StatisticsTimeSelectView> {
  DateTime dateTime = DateTime.now();

  @override
  Widget buildInnerWidget() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (widget.mode == DateRangePickerView.year) {
                    dateTime = DateTime(dateTime.year, dateTime.month - 1, 1);
                  } else {
                    dateTime = DateTime(dateTime.year - 1, 1, 1);
                  }
                  widget.onSelectChange?.call(dateTime);
                });
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: KeepAccountsTheme.nearlyDarkBlue,
              )),
          Expanded(
              child: Text(
            widget.mode == DateRangePickerView.year
                ? '${dateTime.year} 年 ${dateTime.month}月'
                : '${dateTime.year} 年',
            textAlign: TextAlign.center,
            style: KeepAccountsTheme.subtitle,
          )),
          IconButton(
              onPressed: () {
                setState(() {
                  if (widget.mode == DateRangePickerView.year) {
                    dateTime = DateTime(dateTime.year, dateTime.month + 1, 1);
                  } else {
                    dateTime = DateTime(dateTime.year + 1, 1, 1);
                  }
                  widget.onSelectChange?.call(dateTime);
                });
              },
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                color: KeepAccountsTheme.nearlyDarkBlue,
              ))
        ],
      ),
    );
  }
}
