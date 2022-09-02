import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:live_life/keep_accounts/record_transaction/tag_icon_view.dart';

import '../../icons/custom_icons.dart';
import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../ui_view/category_icon_view.dart';
import 'category_select_view.dart';
import 'number_keyboard_view.dart';

class IncomeInputView extends StatefulWidget {
  @override
  _IncomeInputViewState createState() => _IncomeInputViewState();
}

class _IncomeInputViewState extends State<IncomeInputView>
    with TickerProviderStateMixin {
  Future<bool> getData() async {
    return CategoryManager.instance.fetchCategories();
  }

  int selectIndex = 0;

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
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixText: " ¥",
                                  suffixStyle: KeepAccountsTheme.money_income,
                                  hintStyle: KeepAccountsTheme.money_income,
                                  hintText: "0.00"),
                              autofocus: true,
                              textAlign: TextAlign.right,
                              cursorColor: KeepAccountsTheme.green,
                              cursorWidth: 3,
                              style: KeepAccountsTheme.money_income,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return CategorySelectView(
                      color: KeepAccountsTheme.green,
                      categories: CategoryManager.incomeCategories,
                      onSelectCategory: (cid) {
                        //
                      },
                    );
                  }
                },
              ),
            )),
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
                            prefixIconColor: KeepAccountsTheme.green,
                            // contentPadding: EdgeInsets.only(left: 24, top: 4, bottom: 4, right: 24),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.note_add),
                            hintText: "请输入备注信息"),
                        cursorColor: KeepAccountsTheme.green,
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
                const NumberKeyboardView(mainColor: KeepAccountsTheme.green)
              ],
            )
          ],
        ));
  }
}
