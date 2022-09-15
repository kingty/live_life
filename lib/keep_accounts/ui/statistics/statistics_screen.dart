import 'package:flutter/material.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_category_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_line_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_overview_view.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_time_select_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../control/middle_ware.dart';
import '../keep_accounts_them.dart';
import '../ui_view/tab_base_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key, this.animationController})
      : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
  final AnimationController? animationController;
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  DateRangePickerView _mode = DateRangePickerView.year;

  @override
  void initState() {
    listViews.add(StatisticsTimeSelectView(
      mode: _mode,
      index: 1,
      animationController: widget.animationController!,
    ));
    listViews.add(StatisticsOverviewView(
      mode: _mode,
      index: 2,
      animationController: widget.animationController!,
    ));
    listViews.add(StatisticsCategoryView(
      mode: _mode,
      index: 3,
      animationController: widget.animationController!,
    ));
    // listViews.add(StatisticsLineView(
    //   mode: _mode,
    //   index: 4,
    //   animationController: widget.animationController!,
    // ));

    MiddleWare.instance.transaction
        .fetchTransactionsForStatistics(_mode, DateTime.now());

    super.initState();
  }

  @override
  void dispose() {
    MiddleWare.instance.transaction.flashStatisticsTransactionsStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBaseScreen(
        animationController: widget.animationController,
        slivers: _getAllSlivers(),
        title: S.current.KEEP_ACCOUNTS_STATISTICS,
        rightWidget: Row(
          children: <Widget>[
            PopupMenuButton(
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<DateRangePickerView>>[
                      CheckedPopupMenuItem<DateRangePickerView>(
                          checked: _mode == DateRangePickerView.year,
                          value: DateRangePickerView.year,
                          child: const ListTile(
                              leading: Icon(Icons.calendar_view_month),
                              title: Text('按月查看'))),
                      CheckedPopupMenuItem<DateRangePickerView>(
                          checked: _mode == DateRangePickerView.decade,
                          value: DateRangePickerView.decade,
                          child: const ListTile(
                              leading: Icon(Icons.calendar_today),
                              title: Text('按年查看'))),
                    ],
                icon: const Icon(Icons.filter_list_outlined,
                    color: KeepAccountsTheme.nearlyDarkBlue),
                onSelected: (DateRangePickerView value) {
                  setState(() {
                    _mode = value;
                  });
                }),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  List<Widget> _getAllSlivers() {
    final List<Widget> allSlivers = List.empty(growable: true);
    allSlivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      widget.animationController?.forward();
      return listViews[index];
    }, childCount: listViews.length)));
    return allSlivers;
  }
}
