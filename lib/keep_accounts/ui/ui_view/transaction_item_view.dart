import 'package:flutter/material.dart';
import 'package:live_life/icons/custom_icons.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:live_life/keep_accounts/models/category_data.dart';
import '../../../helper.dart';
import '../../control/category_manager.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';
import '../record_transaction/record_transaction_view.dart';
import 'category_icon_view.dart';
import 'gesture_wrapper.dart';

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
  late CategoryData category;
  late Color color;

  @override
  void initState() {
    super.initState();
  }

  String _getName() {
    if (widget.data.getRealAccountId() == null) {
      return "${MiddleWare.instance.account.getAccountById(widget.data.outAccountId).name} -> ${MiddleWare.instance.account.getAccountById(widget.data.inAccountId).name}";
    }
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
    category = CategoryManager.instance.getById(widget.data.categoryId)!;

    if (widget.data.isExpense()) {
      color = KeepAccountsTheme.darkRed;
    } else if (widget.data.isIncome()) {
      color = KeepAccountsTheme.green;
    } else {
      color = category.color;
    }
    return GestureWrapper(
        onTap: () {
          showBottomSheetPanel(context, _getDetail());
        },
        child: _buildMainUI(context));
  }

  Widget _buildMainUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          CategoryIconView(
            iconData: CustomIcons.customIcons[category.icon] ?? Icons.image,
            color: category.color,
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
              "¥ ${widget.data.isExpense() ? "-" : widget.data.isIncome() ? "+" : ""}${widget.data.amount.toStringAsFixed(2)}",
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

  Widget _getDetail() {
    const double height = 40;
    return Container(
      height: 420,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButtonWithInk(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              RecordTransactionView(
                                  transactionData: widget.data.copy())),
                    );
                  },
                  child: const Icon(
                    Icons.edit_note_outlined,
                    color: KeepAccountsTheme.nearlyDarkBlue,
                  )),
              IconButtonWithInk(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: KeepAccountsTheme.nearlyDarkBlue,
                  ))
            ],
          ),
          const Divider(color: KeepAccountsTheme.nearlyDarkBlue),
          Row(
            children: [
              const Text(
                "支出金额",
                style: KeepAccountsTheme.title,
              ),
              const Spacer(),
              const SizedBox(height: height),
              Text(
                "¥ ${widget.data.isExpense() ? "-" : widget.data.isIncome() ? "+" : ""}${widget.data.amount.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: KeepAccountsTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: -0.1,
                  color: color,
                ),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "记账类别",
                style: KeepAccountsTheme.title,
              ),
              const Spacer(),
              const SizedBox(height: height),
              Text(
                category.name,
                style: KeepAccountsTheme.subtitle,
              ),
              const SizedBox(width: 10),
              CategoryIconView(
                size: 14,
                padding: const EdgeInsets.all(8),
                iconData: CustomIcons.customIcons[category.icon] ?? Icons.image,
                color: category.color,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "支出账户",
                style: KeepAccountsTheme.title,
              ),
              const Spacer(),
              const SizedBox(height: height),
              Text('${_getName()} ${_getDes()}',
                  textAlign: TextAlign.center,
                  style: KeepAccountsTheme.subtitle)
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "账单日期",
                style: KeepAccountsTheme.title,
              ),
              const Spacer(),
              const SizedBox(height: height),
              Text(formatTime(widget.data.tranTime),
                  textAlign: TextAlign.center,
                  style: KeepAccountsTheme.subtitle)
            ],
          ),
          const Divider(),
          Visibility(
              visible:
                  MiddleWare.instance.tag.getTagById(widget.data.tagId) != null,
              child: Row(
                children: [
                  const Text(
                    "标签",
                    style: KeepAccountsTheme.title,
                  ),
                  const Spacer(),
                  const SizedBox(height: height),
                  Text(
                      MiddleWare.instance.tag.getTagById(widget.data.tagId) ==
                              null
                          ? ''
                          : MiddleWare.instance.tag
                              .getTagById(widget.data.tagId)!
                              .name,
                      textAlign: TextAlign.center,
                      style: KeepAccountsTheme.subtitle)
                ],
              )),
          Visibility(
              visible:
                  MiddleWare.instance.tag.getTagById(widget.data.tagId) != null,
              child: const Divider()),
          Visibility(
            visible: widget.data.categoryId == CategoryManager.SPECIAL_FINANCE,
            child: Row(
              children: [
                const Text(
                  "理财时间",
                  style: KeepAccountsTheme.title,
                ),
                const Spacer(),
                const SizedBox(height: height),
                Text(
                    "${widget.data.startTime == null ? "无期" : formatTime(widget.data.startTime!)} 到 ${widget.data.endTime == null ? "无期" : formatTime(widget.data.endTime!)}",
                    textAlign: TextAlign.center,
                    style: KeepAccountsTheme.subtitle)
              ],
            ),
          ),
          Visibility(
              visible:
                  widget.data.categoryId == CategoryManager.SPECIAL_FINANCE,
              child: const Divider())
        ],
      ),
    );
  }
}
