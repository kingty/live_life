import 'package:flutter/material.dart';

import '../keep_accounts_them.dart';
import '../models/bank_data.dart';

class SelectAccountAndInputView extends StatefulWidget {
  const SelectAccountAndInputView({super.key, required this.color});

  @override
  _SelectAccountAndInputViewState createState() =>
      _SelectAccountAndInputViewState();
  final Color color;
}

class _SelectAccountAndInputViewState extends State<SelectAccountAndInputView>
    with TickerProviderStateMixin {
  late TextStyle _textStyle;

  @override
  void initState() {
    _textStyle = TextStyle(
      color: widget.color,
      letterSpacing: 0,
      fontSize: 30,
      fontWeight: FontWeight.w400,
    );
    super.initState();
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
        children: <Widget>[
          Row(
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
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: TextField(
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
          )
        ],
      ),
    );
  }
}
