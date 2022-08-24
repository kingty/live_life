import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:live_life/keep_accounts/record_transaction/tag_icon_view.dart';

import '../../icons/custom_icons.dart';
import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../ui_view/category_icon_view.dart';
import 'number_keyboard_view.dart';

class TransferInputView extends StatefulWidget {
  @override
  _TransferInputViewState createState() => _TransferInputViewState();
}

class _TransferInputViewState extends State<TransferInputView>
    with TickerProviderStateMixin {
  Future<bool> getData() async {
    return CategoryManager.instance.fetchCategories();
  }

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
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                                BankData.gydxsyyh["ICBC"]?.logo ?? ""),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("工商银行", style: KeepAccountsTheme.subtitle),
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
                                  suffixStyle: KeepAccountsTheme.money_exchange,
                                  hintStyle: KeepAccountsTheme.money_exchange,
                                  hintText: "0.00"),
                              autofocus: true,
                              textAlign: TextAlign.right,
                              cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                              cursorWidth: 3,
                              style: KeepAccountsTheme.money_exchange,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.currency_exchange,
                color: KeepAccountsTheme.nearlyDarkBlue,
              ),
            ),
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
                          padding: const EdgeInsets.all(10),
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
                                  suffixStyle: KeepAccountsTheme.money_exchange,
                                  hintStyle: KeepAccountsTheme.money_exchange,
                                  hintText: "0.00"),
                              autofocus: true,
                              textAlign: TextAlign.right,
                              cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                              cursorWidth: 3,
                              style: KeepAccountsTheme.money_exchange,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    // constraints: BoxConstraints(maxHeight: 40),
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    color: KeepAccountsTheme.grey.withOpacity(0.1),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: KeepAccountsTheme.background,
                            suffixIconColor: KeepAccountsTheme.nearlyDarkBlue,
                            // contentPadding: EdgeInsets.only(left: 24, top: 4, bottom: 4, right: 24),
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.image),
                            hintText: "请输入备注信息"),
                        cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                      ),
                    )),
                Container(
                  color: KeepAccountsTheme.background,
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                  child: Row(
                    children: const [
                      TagIconView(
                        iconData: Icons.account_balance_wallet_sharp,
                        text: '默认账本',
                      ),

                      SizedBox(width: 10), // 50宽度
                      TagIconView(
                        iconData: Icons.calendar_today,
                        text: '今天',
                      ),

                      SizedBox(width: 10), // 50宽度
                      TagIconView(
                        iconData: Icons.tag,
                        text: '标签',
                      ),
                    ],
                  ),
                ),
                const NumberKeyboardView(mainColor: KeepAccountsTheme.nearlyDarkBlue)
              ],
            )
          ],
        ));
  }
}
