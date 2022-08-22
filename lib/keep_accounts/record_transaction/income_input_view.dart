import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../keep_accounts_them.dart';

class OutcomeInputView extends StatefulWidget {
  @override
  _OutcomeInputViewState createState() => _OutcomeInputViewState();
}

class _OutcomeInputViewState extends State<OutcomeInputView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: KeepAccountsTheme.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
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
                          padding: const EdgeInsets.only(
                              left: 10, right: 8, top: 14, bottom: 8),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                                BankData.gydxsyyh["ABC"]?.logo ?? ""),
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
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixText: " ¥",
                                  suffixStyle: KeepAccountsTheme.money,
                                  hintStyle: KeepAccountsTheme.money,
                                  hintText: "0.00"),
                              autofocus: true,
                              textAlign: TextAlign.right,
                              cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                              cursorWidth: 3,
                              style: KeepAccountsTheme.money,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                      childAspectRatio: 1.0 //宽高比为1时，子widget
                      ),
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast)
                  ],
                ))
          ],
        ));
  }
}
