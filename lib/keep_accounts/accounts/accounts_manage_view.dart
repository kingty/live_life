import 'package:flutter/material.dart';
import 'package:live_life/common_view/common_app_bar.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import '../models/mock_data.dart';
import 'account_item_view.dart';
import 'asset_management_overview_view.dart';

class AccountsManageView extends StatefulWidget {
  @override
  _AccountsManageViewState createState() => _AccountsManageViewState();
}

class _AccountsManageViewState extends State<AccountsManageView>
    with TickerProviderStateMixin {
  var sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    List<Widget> listViews = <Widget>[];
    List<AccountData> accounts = MockData.getAccounts();
    listViews.add(AssetManagementOverviewView());
    return CommonAppBar(
        title: S.current.KEEP_ACCOUNTS_ASSET_MANAGEMENT,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return listViews[index];
          }, childCount: listViews.length)),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return AccountItemView(data: accounts[index]);
            }, childCount: accounts.length),
          )
        ],
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            color: KeepAccountsTheme.pink,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            color: KeepAccountsTheme.nearlyDarkBlue,
          )
        ]);
  }
}
