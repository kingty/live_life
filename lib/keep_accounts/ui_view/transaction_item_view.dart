import 'package:flutter/material.dart';
import 'package:live_life/icons/custom_icons.dart';

import '../keep_accounts_them.dart';
import 'category_icon_view.dart';

class TransactionItemView extends StatefulWidget {
  const TransactionItemView({Key? key}) : super(key: key);

  @override
  _TransactionItemViewState createState() => _TransactionItemViewState();
}

class _TransactionItemViewState extends State<TransactionItemView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: KeepAccountsTheme.deactivatedText,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Row(
          children: <Widget>[
            const CategoryIconView(),
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
                      '餐饮',
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
                          '微信钱包',
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
                            '钱包1',
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
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 3),
              child: Text(
                '¥ 123.00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: KeepAccountsTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: -0.1,
                  color: KeepAccountsTheme.pink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
