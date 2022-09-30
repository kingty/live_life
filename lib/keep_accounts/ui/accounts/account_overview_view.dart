import 'package:flutter/material.dart';
import '../../control/middle_ware.dart';
import '../../models/account_data.dart';
import '../keep_accounts_them.dart';

class AccountOverviewView extends StatelessWidget {
  final AccountData accountData;

  const AccountOverviewView({Key? key, required this.accountData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor = Colors.black12.withOpacity(0.03);
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: KeepAccountsTheme.white,
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
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: borderColor, width: 1))),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: borderColor, width: 1))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "现金",
                                  style: KeepAccountsTheme.caption,
                                ),
                                Text(
                                  "¥ ${(accountData.cash).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ))),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          const Text("理财", style: KeepAccountsTheme.caption),
                          Text(
                            "¥ ${(accountData.financial).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: KeepAccountsTheme.nearlyDarkBlue,
                                fontWeight: FontWeight.w500),
                          ),
                        ]))
                  ])),
              Row(children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: borderColor, width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("负债", style: KeepAccountsTheme.caption),
                            Text(
                              "¥ ${(accountData.debt).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: KeepAccountsTheme.darkRed,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const Text("借出", style: KeepAccountsTheme.caption),
                      Text(
                        "¥ ${(accountData.lend).toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                    ]))
              ])
            ],
          ),
        ));
  }
}
