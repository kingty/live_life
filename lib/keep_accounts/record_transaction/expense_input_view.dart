import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import 'category_select_view.dart';
import 'icon_tag_list_view.dart';
import 'note_input_view.dart';
import 'number_keyboard_view.dart';

class ExpenseInputView extends StatefulWidget {
  @override
  _ExpenseInputViewState createState() => _ExpenseInputViewState();
}

class _ExpenseInputViewState extends State<ExpenseInputView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Future<bool> getData() async {
    return CategoryManager.instance.fetchCategories();
  }

  int selectIndex = 0;
  double position = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          position = 0.0;
        } else {
          position = MediaQuery.of(context).viewInsets.bottom > 290.0
              ? MediaQuery.of(context).viewInsets.bottom - 290.0
              : 0.0;
        }
      });
    });
  }
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: KeepAccountsTheme.background,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: KeepAccountsTheme.nearlyWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
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
                                      suffixStyle:
                                          KeepAccountsTheme.money_expense,
                                      hintStyle:
                                          KeepAccountsTheme.money_expense,
                                      hintText: "0.00"),
                                  autofocus: true,
                                  textAlign: TextAlign.right,
                                  cursorColor: KeepAccountsTheme.purple,
                                  cursorWidth: 3,
                                  style: KeepAccountsTheme.money_expense,
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
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder(
                    future: getData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return CategorySelectView(
                          color: KeepAccountsTheme.pink,
                          categories: CategoryManager.expenseCategories,
                          onSelectCategory: (cid) {
                            //
                          },
                        );
                      }
                    },
                  ),
                )),
                const SizedBox(height: 340)
              ],
            ),
            Positioned(
                bottom: position,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 340,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      NoteInputView(
                        color: KeepAccountsTheme.pink,
                      ),
                      IconTagListView(),
                      NumberKeyboardView(mainColor: KeepAccountsTheme.pink)
                    ],
                  ),
                ))
          ],
        ));
  }
}
