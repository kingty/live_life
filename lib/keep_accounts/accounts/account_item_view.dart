import 'package:flutter/material.dart';
import 'package:live_life/icons/custom_icons.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../models/transaction_data.dart';
import '../ui_view/category_icon_view.dart';

class AccountItemView extends StatefulWidget {
  AccountItemView({Key? key, required this.data}) : super(key: key);
  final AccountData data;

  @override
  _AccountItemViewState createState() => _AccountItemViewState();
}

class _AccountItemViewState extends State<AccountItemView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var bank = BankData.getByKey(widget.data.bankDataKey)!;
    var color = bank.mainColor;
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      // color: KeepAccountsTheme.deactivatedText,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black12.withOpacity(0.05)))),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(bank.logo),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                  child: Text(
                    bank.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: KeepAccountsTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: -0.1,
                      color: KeepAccountsTheme.nearlyBlack.withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.data.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: KeepAccountsTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: -0.1,
                          color: KeepAccountsTheme.grey.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          widget.data.des,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: KeepAccountsTheme.fontName,
                            fontSize: 10,
                            letterSpacing: -0.1,
                            color: KeepAccountsTheme.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 3),
            child: Text(
              "¥ ${double.parse((widget.data.cash + widget.data.financial).toStringAsFixed(2))}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: KeepAccountsTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: -0.1,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
