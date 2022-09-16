import 'package:flutter/material.dart';
import 'package:live_life/icons/custom_icons.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import '../../control/category_manager.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';
import 'category_icon_view.dart';

class TransactionItemView extends StatefulWidget {
  TransactionItemView({Key? key, required this.data, this.hasTopTime = false})
      : super(key: key);
  final TransactionData data;
  bool hasTopTime = false;

  @override
  _TransactionItemViewState createState() => _TransactionItemViewState();
}

class _TransactionItemViewState extends State<TransactionItemView>
    with TickerProviderStateMixin {
  String _getName() {
    if (widget.data.getRealAccountId() == null) return '未知';
    return BankData.getByKey(MiddleWare.instance.account
            .getAccountById(widget.data.getRealAccountId()!)
            .bankDataKey)!
        .name;
  }

  String _getDes() {
    if (widget.data.getRealAccountId() == null) return '';
    return MiddleWare.instance.account
        .getAccountById(widget.data.getRealAccountId()!)
        .name;
  }

  @override
  Widget build(BuildContext context) {
    var category = CategoryManager.instance.getById(widget.data.categoryId)!;
    var color = widget.data.isExpense()
        ? KeepAccountsTheme.darkRed
        : KeepAccountsTheme.green;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          CategoryIconView(
            iconData: CustomIcons.customIcons[category.icon] ?? Icons.image,
            color: color,
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
                    category.name,
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
                        _getName(),
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
                          _getDes(),
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
              "¥ ${widget.data.isExpense() ? "-" : "+"}${widget.data.amount.toString()}",
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
