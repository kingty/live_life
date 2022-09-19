import 'package:flutter/material.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import '../../control/middle_ware.dart';
import '../keep_accounts_them.dart';
import '../transaction_calender/transaction_calender_screen.dart';
import '../ui_view/tab_base_screen.dart';
import '../ui_view/transaction_list_view.dart';
import 'month_overview_view.dart';
import 'title_view.dart';

class ThisMonthOverviewScreen extends StatefulWidget {
  const ThisMonthOverviewScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  // ignore: library_private_types_in_public_api
  _ThisMonthOverviewScreenState createState() =>
      _ThisMonthOverviewScreenState();
}

class _ThisMonthOverviewScreenState extends State<ThisMonthOverviewScreen>
    with TickerProviderStateMixin {
  List<Widget> _listViews = <Widget>[];
  final int _count = 9;

  @override
  void initState() {
    addAllListData();

    super.initState();
  }

  void addAllListData() {
    _listViews.add(
      MonthOverviewView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / _count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    _listViews.add(
      TitleView(
        titleTxt: S.current.KEEP_ACCOUNTS_TRANSACTION,
        subTxt: S.current.KEEP_ACCOUNTS_THIS_MORE,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / _count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => TransactionCalenderScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBaseScreen(
        animationController: widget.animationController,
        slivers: _getAllSlivers(),
        title: S.current.KEEP_ACCOUNTS_OVERVIEW,
        rightWidget: Row(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.calendar_today,
                color: KeepAccountsTheme.grey,
                size: 18,
              ),
            ),
            Text(
              '15 May',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: KeepAccountsTheme.fontName,
                fontWeight: FontWeight.normal,
                fontSize: 18,
                letterSpacing: -0.2,
                color: KeepAccountsTheme.darkerText,
              ),
            ),
          ],
        ));
  }

  Widget _getTransactionListWithAnimator() {
    var animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval((1 / _count) * 3, 1.0, curve: Curves.fastOutSlowIn)));

    return SliverFadeTransition(
        opacity: animation, sliver: _getTransactionList());
  }

  Widget _getTransactionList() {
    return StreamBuilder<List<TransactionData>>(
        stream: MiddleWare.instance.transaction.getLatestTransactionsStream(),
        //
        //initialData: ,// a Stream<int> or null
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionData>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SliverToBoxAdapter(
                child: Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text(
                '目前还没有账单',
                style: KeepAccountsTheme.subtitle,
              ),
            ));
          } else {
            var transactions = snapshot.data ?? List.empty();
            return TransactionListView(
                sectionList: MonthSection.getMonthSections(transactions));
          }
        });
  }

  List<Widget> _getAllSlivers() {
    final List<Widget> allSlivers = List.empty(growable: true);
    allSlivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      widget.animationController?.forward();
      return _listViews[index];
    }, childCount: _listViews.length)));

    allSlivers.add(_getTransactionListWithAnimator());
    return allSlivers;
  }
}
