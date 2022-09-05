import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/record_transaction/number_keyboard_view.dart';

import '../../common_view/dot_line_border.dart';
import '../keep_accounts_them.dart';
import '../models/bank_data.dart';

class SelectAccountAndInputView extends StatefulWidget {
  const SelectAccountAndInputView(
      {super.key,
      required this.color,
      this.withSelectTime = false,
      this.withTransfer = false,
      required this.calculator});

  @override
  _SelectAccountAndInputViewState createState() =>
      _SelectAccountAndInputViewState();
  final Color color;
  final bool withSelectTime;
  final bool withTransfer;
  final Calculator calculator;
}

class _SelectAccountAndInputViewState extends State<SelectAccountAndInputView>
    with TickerProviderStateMixin {
  late TextStyle _textStyle;

  List<Widget> widgets = List.empty(growable: true);
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _textStyle = TextStyle(
      color: widget.color,
      letterSpacing: 0,
      fontSize: 30,
      fontWeight: FontWeight.w400,
    );
    if (widget.withSelectTime) {
      widgets.add(getSelectTimeView());
    }
    if (widget.withTransfer) {
      widgets.add(getSelectAccountAndInputView());
      widgets.add(Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: DottedLineBorder(
              dottedLength: 5,
              dottedSpace: 8,
              top: BorderSide(color: widget.color.withOpacity(0.1), width: 2),
              bottom:
                  BorderSide(color: widget.color.withOpacity(0.1), width: 2)),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.currency_exchange,
          color: widget.color,
        ),
      ));
    }
    widgets.add(getSelectAccountAndInputView());

    widget.calculator.stream().listen((event) {
      if (mounted) {
        focusNode.requestFocus();
        setState(() {
          controller.text = event;
        });
      }
    });

    super.initState();
  }

  Widget getSelectTimeView() {
    return Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          border: DottedLineBorder(
              dottedLength: 5,
              dottedSpace: 8,
              bottom:
                  BorderSide(color: widget.color.withOpacity(0.1), width: 2)),
        ),
        child: Row(
          children: [
            Container(
                width: 5, height: 50, color: widget.color.withOpacity(0.4)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                  Text(
                    "开始时间",
                    style: KeepAccountsTheme.caption,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "2022-9-3",
                    style: KeepAccountsTheme.title,
                  )
                ])),
            Container(
                width: 5, height: 50, color: widget.color.withOpacity(0.4)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                  Text(
                    "结束时间",
                    style: KeepAccountsTheme.caption,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "2022-9-3",
                    style: KeepAccountsTheme.title,
                  )
                ]))
          ],
        ));
  }

  Widget getSelectAccountAndInputView() {

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(BankData.gydxsyyh["ABC"]?.logo ?? ""),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("中国银行", style: KeepAccountsTheme.subtitle),
            Text(
              "储蓄卡",
              style: KeepAccountsTheme.caption,
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: " ¥",
                  suffixStyle: _textStyle,
                  hintStyle: _textStyle,
                  hintText: "0.00"),
              autofocus: true,
              textAlign: TextAlign.right,
              cursorColor: widget.color,
              cursorWidth: 3,
              style: _textStyle,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: KeepAccountsTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: KeepAccountsTheme.grey.withOpacity(0.01),
                offset: const Offset(0.0, 5.0),
                blurRadius: 5.0),
          ],
        ),
        child: Column(
          children: widgets,
        ));
  }
}
