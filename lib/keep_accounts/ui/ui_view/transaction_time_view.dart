import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helper.dart';
import '../../models/ui_data.dart';
import '../keep_accounts_them.dart';

class TransactionTimeView extends StatefulWidget {
  const TransactionTimeView({
    Key? key,
    required this.dayOverViewData,
  }) : super(key: key);

  final DayOverViewData dayOverViewData;

  @override
  _TransactionTimeViewState createState() => _TransactionTimeViewState();
}

class _TransactionTimeViewState extends State<TransactionTimeView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6),
        child: Row(
          children: [
            Text(widget.dayOverViewData.getDisplayDateString(),
                style: KeepAccountsTheme.caption),
            const Spacer(),
            Text("收 ${displayMoneyStr(widget.dayOverViewData.countIncome)}",
                style: KeepAccountsTheme.caption),
            const SizedBox(width: 10),
            Text("支 ${displayMoneyStr(widget.dayOverViewData.countExpense)}",
                style: KeepAccountsTheme.caption),
          ],
        ));
  }
}
