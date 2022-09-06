import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/accounts/account_item_view.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/mock_data.dart';
import 'package:live_life/keep_accounts/record_transaction/number_keyboard_view.dart';

import '../../common_view/dot_line_border.dart';
import '../../helper.dart';
import '../keep_accounts_them.dart';
import '../models/bank_data.dart';

class SelectAccountAndInputView extends StatefulWidget {
  const SelectAccountAndInputView(
      {super.key,
      required this.color,
      this.withSelectTime = false,
      this.withTransfer = false,
      required this.calculator});

  @override
  _SelectAccountAndInputViewState createState() =>
      _SelectAccountAndInputViewState();
  final Color color;
  final bool withSelectTime;
  final bool withTransfer;
  final Calculator calculator;
}

class _SelectAccountAndInputViewState extends State<SelectAccountAndInputView>
    with TickerProviderStateMixin {
  late TextStyle _textStyle;

  List<Widget> widgets = List.empty(growable: true);
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<AccountData> accounts = MockData.getAccounts();
  late AccountData selectAccount;
  late AccountData selectAccountBelow;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectAccount = accounts.first;
    selectAccountBelow = accounts.first;
    _textStyle = TextStyle(
      color: widget.color,
      letterSpacing: 0,
      fontSize: 30,
      fontWeight: FontWeight.w400,
    );

    widget.calculator.stream().listen((event) {
      if (mounted) {
        focusNode.requestFocus();
        setState(() {
          controller.text = event;
        });
      }
    });

    super.initState();
  }

  Widget getAccountsList(List<AccountData> accounts, bool below) {
    return ListView.separated(
      itemCount: accounts.length,
      itemBuilder: (BuildContext context, int index) {
        var account = accounts[index];
        return InkWell(
            onTap: () {
              setState(() {
                if (below) {
                  selectAccountBelow = account;
                } else {
                  selectAccount = account;
                }
              });

              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                decoration: (below
                        ? selectAccountBelow == account
                        : selectAccount == account)
                    ? BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      )
                    : null,
                margin: const EdgeInsets.only(left: 14, right: 14),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: AccountItemView(data: account)));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.black12.withOpacity(0.05),
          indent: 12,
          endIndent: 12,
        );
      },
    );
  }

  Widget getSelectTimeView() {
    return Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          border: DottedLineBorder(
              dottedLength: 5,
              dottedSpace: 8,
              bottom:
                  BorderSide(color: widget.color.withOpacity(0.1), width: 2)),
        ),
        child: Row(
          children: [
            Container(
                width: 5, height: 50, color: widget.color.withOpacity(0.4)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                  Text(
                    "开始时间",
                    style: KeepAccountsTheme.caption,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "2022-9-3",
                    style: KeepAccountsTheme.title,
                  )
                ])),
            Container(
                width: 5, height: 50, color: widget.color.withOpacity(0.4)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                  Text(
                    "结束时间",
                    style: KeepAccountsTheme.caption,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "2022-9-3",
                    style: KeepAccountsTheme.title,
                  )
                ]))
          ],
        ));
  }

  Widget getSelectAccountAndInputView(bool below) {
    var theAccount = below ? selectAccountBelow : selectAccount;
    var accountBankName =
        BankData.getByKey(theAccount.bankDataKey)!.simpleName();
    var accountName = theAccount.name;
    var logoPath = BankData.getByKey(theAccount.bankDataKey)!.logo;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(logoPath),
          ),
        ),
        InkWell(
            onTap: () {
              showBottomSheetPanel(
                  context,
                  SizedBox(
                      height: 400, child: getAccountsList(accounts, below)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(accountBankName, style: KeepAccountsTheme.title),
                Text(
                  accountName,
                  style: KeepAccountsTheme.caption,
                )
              ],
            )),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: " ¥",
                  suffixStyle: _textStyle,
                  hintStyle: _textStyle,
                  hintText: "0.00"),
              autofocus: true,
              textAlign: TextAlign.right,
              cursorColor: widget.color,
              cursorWidth: 3,
              style: _textStyle,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          children: [
            Visibility(
                maintainSize: false,
                visible: widget.withSelectTime,
                child: getSelectTimeView()),
            Visibility(
                maintainSize: false,
                visible: widget.withTransfer,
                child: getSelectAccountAndInputView(false)),
            Visibility(
                maintainSize: false,
                visible: widget.withTransfer,
                child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: DottedLineBorder(
                        dottedLength: 5,
                        dottedSpace: 8,
                        top: BorderSide(
                            color: widget.color.withOpacity(0.1), width: 2),
                        bottom: BorderSide(
                            color: widget.color.withOpacity(0.1), width: 2)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.currency_exchange,
                    color: widget.color,
                  ),
                )),
            getSelectAccountAndInputView(true)
          ],
        ));
  }
}
