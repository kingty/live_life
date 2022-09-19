import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common_view/common_app_bar.dart';
import '../../../generated/l10n.dart';
import '../../../helper.dart';
import '../keep_accounts_them.dart';
import '../../models/transaction_data.dart';
import '../ui_view/transaction_list_view.dart';
import 'custom_date_picker_view.dart';

class TransactionCalenderView extends StatefulWidget {
  const TransactionCalenderView({Key? key}) : super(key: key);

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

  @override
  void dispose() {
    _controller.dispose();
    MiddleWare.instance.transaction.flashCalenderTransactionsStream();
    super.dispose();
  }

  _setSpecialDates(PickerDateRange range) async {
    if (range.startDate == null) return List.empty();
    if (range.endDate == null) return List.empty();
    Set<int> dates = Set.identity();
    var transactions = await MiddleWare.instance.transaction
        .getCalenderTransactionsStream()
        .first;
    for (var transaction in transactions) {
      dates.add(getDateBegin(transaction.tranTime).millisecondsSinceEpoch);
    }
    setState(() {
      _specialDates =
          dates.map((e) => DateTime.fromMillisecondsSinceEpoch(e)).toList();
    });
  }

  Widget _getTransactionList() {
    var empty = SliverToBoxAdapter(
        child: Container(
      alignment: Alignment.center,
      height: 200,
      child: const Text(
        '目前还没有账单',
        style: KeepAccountsTheme.subtitle,
      ),
    ));
    return StreamBuilder<List<TransactionData>>(
        stream: MiddleWare.instance.transaction.getCalenderTransactionsStream(),
        //
        //initialData: ,// a Stream<int> or null
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionData>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return empty;
          } else {
            var transactions = snapshot.data ?? List.empty();
            if (_controller.view == DateRangePickerView.month) {
              transactions = transactions
                  .where((tran) => isSameDay(tran.tranTime, _selectedDate))
                  .toList();
            }
            if (transactions.isEmpty) return empty;
            return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                sliver: TransactionListView(
                    sectionList: MonthSection.getMonthSections(transactions)));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
        title: S.current.KEEP_ACCOUNTS_TRANSACTION_CALENDER,
        slivers: [
          SliverToBoxAdapter(
              child: CustomDatePickerView(
            controller: _controller,
            specialDates: _specialDates,
            onViewChanged: (DateRangePickerViewChangedArgs args) {
              final PickerDateRange visibleDateRange = args.visibleDateRange;
              if (args.view == DateRangePickerView.month) {
                MiddleWare.instance.transaction
                    .fetchTransactionsForCalender(DateRangePickerView.month,
                        visibleDateRange.startDate ?? DateTime.now())
                    .then((value) => {_setSpecialDates(visibleDateRange)});
              }
            },
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is DateTime) {
                setState(() {
                  _selectedDate = args.value;
                  if (_controller.view == DateRangePickerView.year) {
                    MiddleWare.instance.transaction
                        .fetchTransactionsForCalender(
                            DateRangePickerView.year, _selectedDate);
                  } else if (_controller.view == DateRangePickerView.decade) {
                    MiddleWare.instance.transaction
                        .fetchTransactionsForCalender(
                            DateRangePickerView.decade, _selectedDate);
                  }
                });
              } else {
                throw Exception('error return ');
              }
            },
          )),
          _getTransactionList()
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
                  _controller.selectedDate = DateTime.now();
                  if (_mode == DateRangePickerView.year ||
                      _mode == DateRangePickerView.decade) {
                    // 切换时，年和月度查看，主动拉取一下更新数据
                    MiddleWare.instance.transaction
                        .fetchTransactionsForCalender(_mode, _selectedDate);
                  }
                });
              }),
          const SizedBox(
            width: 10,
          ),
        ]);
  }
}
