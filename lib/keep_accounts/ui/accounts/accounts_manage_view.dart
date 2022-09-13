import 'package:flutter/material.dart';
import 'package:live_life/common_view/common_app_bar.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/db/data_provider.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/ui/accounts/select_account_list_view.dart';
import '../../models/mock_data.dart';
import '../keep_accounts_them.dart';
import 'account_item_view.dart';
import 'asset_management_overview_view.dart';

class AccountsManageView extends StatefulWidget {
  const AccountsManageView({Key? key}) : super(key: key);

  @override
  _AccountsManageViewState createState() => _AccountsManageViewState();
}

class _AccountsManageViewState extends State<AccountsManageView>
    with TickerProviderStateMixin {
  var sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    List<Widget> listViews = <Widget>[];
    listViews.add(AssetManagementOverviewView());
    return CommonAppBar(
        title: S.current.KEEP_ACCOUNTS_ASSET_MANAGEMENT,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return listViews[index];
          }, childCount: listViews.length)),
          StreamBuilder<List<AccountData>>(
              stream: MiddleWare.instance.account.getAccountsStream(), //
              //initialData: ,// a Stream<int> or null
              builder: (BuildContext context,
                  AsyncSnapshot<List<AccountData>> snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                      child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const Text(
                      '目前还没有账户',
                      style: KeepAccountsTheme.subtitle,
                    ),
                  ));
                } else {
                  var accounts = snapshot.data ?? List.empty();
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12.withOpacity(0.05)))),
                        margin: const EdgeInsets.only(left: 24, right: 24),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: AccountItemView(data: accounts[index]),
                      );
                    }, childCount: accounts.length),
                  );
                }
              })
        ],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => SelectAccountListView(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            color: KeepAccountsTheme.nearlyDarkBlue,
          ),
          const SizedBox(
            width: 10,
          )
        ]);
  }
}
