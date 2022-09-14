import 'package:flutter/material.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/account_data.dart';
import 'package:live_life/keep_accounts/ui/accounts/select_account_list_view.dart';
import '../keep_accounts_them.dart';
import '../ui_view/tab_base_screen.dart';
import 'account_item_view.dart';
import 'asset_management_overview_view.dart';

class AccountsManageView extends StatefulWidget {
  const AccountsManageView({Key? key, this.animationController})
      : super(key: key);

  @override
  _AccountsManageViewState createState() => _AccountsManageViewState();
  final AnimationController? animationController;
}

class _AccountsManageViewState extends State<AccountsManageView>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final int _count = 9;

  @override
  void initState() {
    listViews.add(AssetManagementOverviewView(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: widget.animationController!,
          curve: Interval((1 / _count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
      animationController: widget.animationController,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBaseScreen(
        animationController: widget.animationController,
        slivers: _getAllSlivers(),
        title: S.current.KEEP_ACCOUNTS_ASSET_MANAGEMENT,
        rightWidget: Row(
          children: <Widget>[
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
          ],
        ));
  }

  List<Widget> _getAllSlivers() {
    final List<Widget> allSlivers = List.empty(growable: true);
    allSlivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      widget.animationController?.forward();
      return listViews[index];
    }, childCount: listViews.length)));

    allSlivers.add(_getAccountListViewWithAnimator());
    return allSlivers;
  }

  Widget _getAccountListViewWithAnimator() {
    var animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval((1 / _count) * 2, 1.0, curve: Curves.fastOutSlowIn)));

    return SliverFadeTransition(
        opacity: animation, sliver: _getAccountListView());
  }

  Widget _getAccountListView() {
    return StreamBuilder<List<AccountData>>(
        stream: MiddleWare.instance.account.getAccountsStream(), //
        //initialData: ,// a Stream<int> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<AccountData>> snapshot) {
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
        });
  }
}
