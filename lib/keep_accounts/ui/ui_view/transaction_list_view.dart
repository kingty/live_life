import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/ui_view/transaction_item_view.dart';
import 'package:live_life/keep_accounts/ui/ui_view/transaction_time_view.dart';
import '../../../common_view/list/src/sliver_expandable_list.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({Key? key, required this.sectionList})
      : super(key: key);
  final List<MonthSection> sectionList;

  @override
  _TransactionListViewState createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverExpandableList(
      builder: SliverExpandableChildDelegate<ListItem, MonthSection>(
        sectionList: widget.sectionList,
        headerBuilder: _buildHeader,
        itemBuilder: (context, sectionIndex, itemIndex, index) {
          var item = widget.sectionList[sectionIndex].items[itemIndex];
          if (item.hasTimeHeader) {
            return Column(children: [
              TransactionTimeView(dayOverViewData: item.dayOverViewData!),
              TransactionItemView(
                  data: item.transactionData, hasTopTime: item.hasTimeHeader)
            ]);
          } else {
            return TransactionItemView(
                data: item.transactionData, hasTopTime: item.hasTimeHeader);
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    MonthSection section = widget.sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: KeepAccountsTheme.background,
            height: 48,
            padding: EdgeInsets.only(left: 24),
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "${section.month}月",
                  style: const TextStyle(
                      color: KeepAccountsTheme.dark_grey, fontSize: 16)),
              WidgetSpan(
                child: Icon(
                  section.expanded
                      ? Icons.arrow_drop_down_outlined
                      : Icons.arrow_right_outlined,
                  size: 16,
                  color: KeepAccountsTheme.dark_grey,
                ),
              ),
            ]))),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }
}

class ListItem {
  bool hasTimeHeader = false;
  late TransactionData transactionData;
  DayOverViewData? dayOverViewData;
}

class MonthSection implements ExpandableListSection<ListItem> {
  //store expand state.
  late bool expanded;

  late List<ListItem> items;

  late int month;

  @override
  List<ListItem> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }

  static List<MonthSection> getMonthSections(
      List<TransactionData> transactions) {
    var sections = List<MonthSection>.empty(growable: true);
    if (transactions.isEmpty) return sections;

    transactions.sort((a, b) {
      return b.tranTime.compareTo(a.tranTime);
    });

    int preMonth = -1;
    int preDay = -1;
    MonthSection? section;
    DayOverViewData? preDayOverViewData;
    //账单按月分组
    for (var transaction in transactions) {
      if (transaction.getMonth() != preMonth) {
        preMonth = transaction.getMonth();
        section = MonthSection()
          ..month = preMonth
          ..expanded = true
          ..items = List.empty(growable: true);
        sections.add(section);
      }
      //每天第一个账单上添加时间
      var item = ListItem()..transactionData = transaction;
      if (transaction.getDay() != preDay) {
        preDay = transaction.getDay();
        item.hasTimeHeader = true;
        preDayOverViewData = DayOverViewData(transaction.tranTime);
        item.dayOverViewData = preDayOverViewData;
      }
      if (preDayOverViewData != null) {
        if (transaction.isExpense()) {
          // 消费
          preDayOverViewData.countExpense = double.parse(
              (preDayOverViewData.countExpense + transaction.amount)
                  .toStringAsFixed(2));
        } else if (transaction.isIncome()){
          preDayOverViewData.countIncome = double.parse(
              (preDayOverViewData.countIncome + transaction.amount)
                  .toStringAsFixed(2));

        }
      }
      section!.items.add(item);
    }

    return sections;
  }
}
