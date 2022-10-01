import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/ui/accounts/edit_account_view.dart';
import 'package:live_life/keep_accounts/ui/ui_view/transaction_list_view.dart';

import '../../../common_view/common_app_bar.dart';
import '../../control/middle_ware.dart';
import '../../models/bank_data.dart';
import '../../models/transaction_data.dart';
import '../keep_accounts_them.dart';
import '../ui_view/gesture_wrapper.dart';
import 'account_overview_view.dart';

class AccountDetailListScreen extends StatelessWidget {
  final AccountData accountData;

  const AccountDetailListScreen({super.key, required this.accountData});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: BankData.getByKey(accountData.bankDataKey)!.name,
      subTitle: "${accountData.name}\n${accountData.des}",
      slivers: [
        SliverToBoxAdapter(
            child: AccountOverviewView(accountData: accountData)),
        _getTransactionList()
      ],
      actions: [
        IconButtonWithInk(
            onTap: () {
              if (accountData.isDefaultAccount()) return;
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      EditAccountScreen(accountData: accountData),
                ),
              );
            },
            child: Icon(Icons.edit,
                color: accountData.isDefaultAccount()
                    ? Colors.grey
                    : KeepAccountsTheme.nearlyDarkBlue))
      ],
    );
  }

  Widget _getTransactionList() {
    var empty = SliverToBoxAdapter(
        child: Container(
      alignment: Alignment.center,
      height: 200,
      child: const Text(
        '目前还没有账单',
        style: KeepAccountsTheme.subtitle,
      ),
    ));
    return FutureBuilder<List<TransactionData>>(
        future: MiddleWare.instance.transaction
            .fetchTransactionsByAccount(accountData),
        //
        //initialData: ,// a Stream<int> or null
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionData>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return empty;
          } else {
            var transactions = snapshot.data ?? List.empty();

            if (transactions.isEmpty) return empty;
            return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                sliver: TransactionListView(
                    sectionList: MonthSection.getMonthSections(transactions)));
          }
        });
  }
}
