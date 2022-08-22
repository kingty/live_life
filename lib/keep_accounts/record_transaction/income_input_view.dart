import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../../icons/custom_icons.dart';
import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../ui_view/category_icon_view.dart';

class IncomeInputView extends StatefulWidget {
  @override
  _IncomeInputViewState createState() => _IncomeInputViewState();
}

class _IncomeInputViewState extends State<IncomeInputView>
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
                    List<Widget> icons = <Widget>[];
                    int i = 0;
                    for (var element in CategoryManager.incomeCategories) {
                      i++;
                      if (i == 1) {
                        var c = Column(
                          children: [
                            CategoryIconView(
                                color: KeepAccountsTheme.green,
                                iconData:
                                    CustomIcons.customIcons[element.icon]!),
                            Padding(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  element.name,
                                  style: KeepAccountsTheme.caption,
                                ))
                          ],
                        );
                        icons.add(c);
                      } else {
                        var c = Column(
                          children: [
                            CategoryIconView(
                                iconData:
                                    CustomIcons.customIcons[element.icon]!),
                            Padding(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  element.name,
                                  style: KeepAccountsTheme.caption,
                                ))
                          ],
                        );
                        icons.add(c);
                      }
                    }
                    return GridView.count(
                      // childAspectRatio: 2,
                      // padding: const EdgeInsets.all(40.0),
                      // crossAxisSpacing: 20.0,
                      // mainAxisSpacing: 10.0,
                      crossAxisCount: 5,

                      children: icons,
                    );
                  }
                },
              ),
            ))
          ],
        ));
  }
}
