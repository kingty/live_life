import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';
import '../../../common_view/common_app_bar.dart';
import '../../../generated/l10n.dart';
import '../../../helper.dart';
import '../keep_accounts_them.dart';

class EditAccountScreen extends StatefulWidget {
  final BankData? bankData;
  final AccountData? accountData;

  const EditAccountScreen({super.key, this.bankData, this.accountData});

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen>
    with TickerProviderStateMixin {
  late BankData bank;
  bool _checkboxListChecked = true;
  final TextEditingController _inputAccountController = TextEditingController();
  final TextEditingController _inputDesController = TextEditingController();
  final TextEditingController _inputAmountController = TextEditingController();
  late AccountData _accountData;

  String? _error;

  @override
  void initState() {
    if (widget.bankData != null) {
      bank = widget.bankData!;
    } else {
      bank = BankData.getByKey(widget.accountData!.bankDataKey)!;
    }
    if (widget.accountData != null) {
      _accountData = widget.accountData!;
      _inputAccountController.text = _accountData.name;
      _inputDesController.text = _accountData.des;
      _inputAmountController.text = _accountData.cash.toStringAsFixed(2);
    } else {
      _accountData = AccountData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: S.current.KEEP_ACCOUNTS_EDIT_ACCOUNT, slivers: [
      SliverToBoxAdapter(
          child: Container(
        margin: const EdgeInsets.all(24),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 15, right: 10),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(bank.logo),
                    )),
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
              ],
            ),
            const Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
                child: Text(
                  "账户名称",
                  style: KeepAccountsTheme.subtitle,
                )),
            Container(
                decoration: BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: KeepAccountsTheme.grey.withOpacity(0.01),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 5.0),
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: _inputAccountController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: KeepAccountsTheme.deactivatedText,
                        letterSpacing: 0,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "请输入账户名称..."),
                  textAlign: TextAlign.left,
                  cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                  cursorWidth: 2,
                  style: const TextStyle(
                    color: KeepAccountsTheme.nearlyDarkBlue,
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
                child: Text(
                  "备注信息",
                  style: KeepAccountsTheme.subtitle,
                )),
            Container(
                decoration: BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: KeepAccountsTheme.grey.withOpacity(0.01),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 5.0),
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: _inputDesController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: KeepAccountsTheme.deactivatedText,
                        letterSpacing: 0,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "请输入备注信息(可不填)"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 5,
                  textAlign: TextAlign.left,
                  cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                  cursorWidth: 2,
                  style: const TextStyle(
                    color: KeepAccountsTheme.nearlyDarkBlue,
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
                child: Text(
                  "账户总额",
                  style: KeepAccountsTheme.subtitle,
                )),
            Container(
                decoration: BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: KeepAccountsTheme.grey.withOpacity(0.01),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 5.0),
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _inputAmountController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: KeepAccountsTheme.deactivatedText,
                        letterSpacing: 0,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "请输入账户总额(活期+理财)"),
                  textAlign: TextAlign.left,
                  cursorColor: KeepAccountsTheme.nearlyDarkBlue,
                  cursorWidth: 2,
                  style: const TextStyle(
                    color: KeepAccountsTheme.nearlyDarkBlue,
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            CheckboxListTile(
              value: _checkboxListChecked,
              onChanged: (isCheck) {
                setState(() {
                  _checkboxListChecked = isCheck!;
                });
              },
              activeColor: KeepAccountsTheme.nearlyDarkBlue,
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: const Text(
                    "余额变动差值计入账单",
                    style: KeepAccountsTheme.caption,
                  )),
              selected: false,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, bottom: 5, right: 10),
                child: Text(
                  _error ?? "",
                  style: KeepAccountsTheme.error,
                ))
          ],
        ),
      )),
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: Text("保存"),
              ),
              onPressed: () {
                _checkInputAndDeal();
              },
            )),
      )
    ]);
  }

  void _checkInputAndDeal() {
    if (_inputAccountController.value.text.isEmpty) {
      setState(() {
        _error = "* 名字不能为空！";
      });

      return;
    }
    if (!isNumeric(_inputAmountController.value.text)) {
      setState(() {
        _error = "* 请输入正确的数字";
      });
      return;
    }
    setState(() {
      _error = "";
    });

    double gap = double.parse(double.parse(_inputAmountController.value.text)
            .toStringAsFixed(2)) -
        _accountData.cash;
    _accountData
      ..bankDataKey = bank.key
      ..name = _inputAccountController.value.text
      ..des = _inputDesController.value.text
      ..cash = double.parse(_inputAmountController.value.text);
    if (_accountData.id.isEmpty) {
      _accountData.id = uuid.v1();
    }
    if (kDebugMode) {
      print(_accountData.toMap());
    }
    MiddleWare.instance.account
        .saveAccount(_accountData,
            needTransaction: _checkboxListChecked, gap: gap)
        .then((value) => Navigator.pop(context));
  }
}
