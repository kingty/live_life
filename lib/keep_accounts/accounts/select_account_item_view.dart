import 'package:flutter/material.dart';
import 'package:live_life/icons/custom_icons.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../models/transaction_data.dart';
import '../ui_view/category_icon_view.dart';

class SelectAccountItemView extends StatefulWidget {
  const SelectAccountItemView({Key? key, required this.data}) : super(key: key);
  final BankData data;

  @override
  // ignore: library_private_types_in_public_api
  _SelectAccountItemViewState createState() => _SelectAccountItemViewState();
}

class _SelectAccountItemViewState extends State<SelectAccountItemView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var bank = widget.data;
    var color = bank.mainColor;
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              bank.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: KeepAccountsTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.1,
                color: KeepAccountsTheme.nearlyBlack.withOpacity(0.8),
              ),
            ),
          )),
          Icon(Icons.keyboard_arrow_right_outlined,
              color: KeepAccountsTheme.lightText.withOpacity(0.8))
        ],
      ),
    );
  }
}
