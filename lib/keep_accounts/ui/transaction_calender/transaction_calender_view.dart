import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common_view/common_app_bar.dart';
import '../../../generated/l10n.dart';
import '../../../helper.dart';
import '../keep_accounts_them.dart';
import '../../models/mock_data.dart';
import '../../models/transaction_data.dart';
import '../ui_view/transaction_list_view.dart';
import 'custom_date_picker_view.dart';

class TransactionCalenderView extends StatefulWidget {
  @override
  _TransactionCalenderViewState createState() =>
      _TransactionCalenderViewState();
}

class _TransactionCalenderViewState extends State<TransactionCalenderView>
    with TickerProviderStateMixin {
  DateRangePickerView _mode = DateRangePickerView.month;
  final DateRangePickerController _controller = DateRangePickerController();
  List<DateTime> _specialDates = List.empty();
  DateTime _selectedDate = getDateBegin(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  Future<List<TransactionData>> getData() async {
    var section = await MockData.getTransactions();
    return section;
  }

  _setSpecialDates(PickerDateRange range) async {
    if (range.startDate == null) return List.empty();
    if (range.endDate == null) return List.empty();

    final DateTime startDate = range.startDate!;
    Set<int> dates = Set.identity();
    var transactions = await MiddleWare.instance.transaction
        .fetchTransactionsByMonth(startDate);
    for (var transaction in transactions) {
      dates.add(getDateBegin(transaction.tranTime).millisecondsSinceEpoch);
    }
    setState(() {
      _specialDates =
          dates.map((e) => DateTime.fromMillisecondsSinceEpoch(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionData>>(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TransactionData>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return CommonAppBar(
              title: S.current.KEEP_ACCOUNTS_TRANSACTION_CALENDER,
              slivers: [
                SliverToBoxAdapter(
                    child: CustomDatePickerView(
                  controller: _controller,
                  specialDates: _specialDates,
                  onViewChanged: (DateRangePickerViewChangedArgs args) {
                    final PickerDateRange visibleDateRange =
                        args.visibleDateRange;
                    if (args.view == DateRangePickerView.month) {
                      _setSpecialDates(visibleDateRange);
                    }
                  },
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is DateTime) {
                      setState(() {
                        _selectedDate = args.value;
                      });
                      if (kDebugMode) {
                        print(_selectedDate);
                      }
                    } else {
                      throw Exception('error return ');
                    }
                  },
                )),
                TransactionListView(
                    sectionList:
                        MonthSection.getMonthSections(snapshot.requireData))
              ],
              actions: [
                PopupMenuButton(
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<DateRangePickerView>>[
                          CheckedPopupMenuItem<DateRangePickerView>(
                              checked: _mode == DateRangePickerView.month,
                              value: DateRangePickerView.month,
                              child: const ListTile(
                                  leading: Icon(Icons.calendar_view_day),
                                  title: Text('按天查看'))),
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
                        _controller.view = value;
                      });
                    }),
                const SizedBox(
                  width: 10,
                ),
              ]);
        }
      },
    );
  }
}