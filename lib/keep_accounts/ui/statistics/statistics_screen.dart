import 'package:flutter/material.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_time_select_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../keep_accounts_them.dart';
import '../overview/month_overview_view.dart';
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
      index: 1,
      animationController: widget.animationController!,
    ));
    super.initState();
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
