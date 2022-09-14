import 'package:flutter/material.dart';
import 'package:live_life/generated/l10n.dart';
import 'package:live_life/keep_accounts/models/mock_data.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import '../../control/middle_ware.dart';
import '../accounts/accounts_manage_view.dart';
import '../keep_accounts_them.dart';
import '../transaction_calender/transaction_calender_view.dart';
import '../ui_view/transaction_list_view.dart';
import 'month_overview_view.dart';
import 'title_view.dart';
import 'accounts_list_view.dart';

class KeepAccountsOverviewScreen extends StatefulWidget {
  const KeepAccountsOverviewScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  // ignore: library_private_types_in_public_api
  _KeepAccountsOverviewScreenState createState() =>
      _KeepAccountsOverviewScreenState();
}

class _KeepAccountsOverviewScreenState extends State<KeepAccountsOverviewScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      MonthOverviewView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: S.current.KEEP_ACCOUNTS_ACCOUNT,
        subTxt: S.current.KEEP_ACCOUNTS_THIS_EDIT,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const AccountsManageView(),
            ),
          );
        },
      ),
    );

    listViews.add(
      AccountsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: S.current.KEEP_ACCOUNTS_TRANSACTION,
        subTxt: S.current.KEEP_ACCOUNTS_THIS_MORE,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 4, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => TransactionCalenderView(),
            ),
          );
        },
      ),
    );

    // for (int i = 0; i< 9; i++ ) {
    //   listViews.add(const TransactionItemView());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KeepAccountsTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
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
            return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                sliver: TransactionListView(
                    sectionList: MonthSection.getMonthSections(transactions)));
          }
        });
  }

  List<Widget> _getAllSlivers() {
    final List<Widget> allSlivers = List.empty(growable: true);
    allSlivers.add(SliverPadding(
        padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top +
                24),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          widget.animationController?.forward();
          return listViews[index];
        }, childCount: listViews.length))));

    allSlivers.add(_getTransactionList());
    return allSlivers;
  }

  Widget getMainListViewUI() {
    return CustomScrollView(
      controller: scrollController,
      slivers: _getAllSlivers(),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: KeepAccountsTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: KeepAccountsTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  S.current.KEEP_ACCOUNTS_OVERVIEW,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: KeepAccountsTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: KeepAccountsTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
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
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}