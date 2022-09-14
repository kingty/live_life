import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import '../../../common_view/date_picker_dialog.dart';
import '../../../common_view/dot_line_border.dart';
import '../../../helper.dart';
import '../../control/middle_ware.dart';
import '../accounts/account_item_view.dart';
import '../keep_accounts_them.dart';
import '../../models/bank_data.dart';
import 'number_keyboard_view.dart';

class SelectAccountAndTimeData {
  late AccountData selectAccount;
  late AccountData selectAccountBelow;
  DateTime? startTime;
  DateTime? endTime;
}

class SelectAccountAndInputView extends StatefulWidget {
  const SelectAccountAndInputView(
      {super.key,
      required this.color,
      this.withSelectTime = false,
      this.withTransfer = false,
      required this.calculator,
      this.onSelectChanged});

  @override
  _SelectAccountAndInputViewState createState() =>
      _SelectAccountAndInputViewState();
  final Color color;
  final bool withSelectTime;
  final bool withTransfer;
  final Calculator calculator;
  final ValueChanged<SelectAccountAndTimeData>? onSelectChanged;
}

class _SelectAccountAndInputViewState extends State<SelectAccountAndInputView>
    with TickerProviderStateMixin {
  late TextStyle _textStyle;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late List<AccountData> _accounts;
  late AccountData _selectAccount;
  late AccountData _selectAccountBelow;

  late DateTime _startTime;
  DateTime? _endTime;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _startTime = DateTime.now();
    _textStyle = TextStyle(
      color: widget.color,
      letterSpacing: 0,
      fontSize: 30,
      fontWeight: FontWeight.w400,
    );

    widget.calculator.stream().listen((event) {
      if (mounted) {
        _focusNode.requestFocus();
        setState(() {
          _controller.text = event;
        });
      }
    });

    super.initState();
  }

  _onChange() {
    widget.onSelectChanged?.call(SelectAccountAndTimeData()
      ..selectAccount = _selectAccount
      ..selectAccountBelow = _selectAccountBelow
      ..startTime = _startTime
      ..endTime = _endTime);
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
                  _selectAccountBelow = account;
                } else {
                  _selectAccount = account;
                }
                _onChange();
              });

              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                decoration: (below
                        ? _selectAccountBelow == account
                        : _selectAccount == account)
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
                child: InkWell(
                    onTap: () async {
                      final DateTime? date = await showDialog<DateTime?>(
                          context: context,
                          builder: (BuildContext context) {
                            return DateRangePickerDlg(
                              _startTime,
                              null,
                              displayDate: _startTime,
                            );
                          });
                      if (date != null) {
                        setState(() {
                          _startTime = date;
                        });
                        _onChange();
                      }
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "开始时间",
                            style: KeepAccountsTheme.caption,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            formatTime(_startTime),
                            style: KeepAccountsTheme.title,
                          )
                        ]))),
            Container(
                width: 5, height: 50, color: widget.color.withOpacity(0.4)),
            const SizedBox(width: 10),
            Expanded(
                child: InkWell(
                    onTap: () async {
                      final DateTime? date = await showDialog<DateTime?>(
                          context: context,
                          builder: (BuildContext context) {
                            return DateRangePickerDlg(
                              _endTime ?? DateTime.now(),
                              null,
                              displayDate: _endTime ?? DateTime.now(),
                            );
                          });

                      setState(() {
                        _endTime = date;
                      });
                      _onChange();
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "结束时间",
                            style: KeepAccountsTheme.caption,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _endTime == null ? "---" : formatTime(_endTime!),
                            style: KeepAccountsTheme.title,
                          )
                        ])))
          ],
        ));
  }

  Widget getSelectAccountAndInputView(bool below) {
    var theAccount = below ? _selectAccountBelow : _selectAccount;
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
                      height: 400, child: getAccountsList(_accounts, below)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: accountBankName, style: KeepAccountsTheme.subtitle),
                  const WidgetSpan(
                    child: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 14,
                      color: KeepAccountsTheme.dark_grey,
                    ),
                  ),
                ])),
                Text(
                  accountName,
                  style: KeepAccountsTheme.smallDetail,
                )
              ],
            )),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
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
    return StreamBuilder<List<AccountData>>(
        stream: MiddleWare.instance.account.getAccountsStream(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AccountData>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox();
          } else {
            _accounts = snapshot.data!;
            _selectAccount = _accounts.first;
            _selectAccountBelow = _accounts.first;
            _onChange();

            return buildWhenGetData();
          }
        });
  }

  Widget buildWhenGetData() {
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
