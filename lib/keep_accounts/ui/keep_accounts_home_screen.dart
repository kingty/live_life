import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/record_transaction/record_transaction_screen.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_screen.dart';
import 'accounts/accounts_manage_screen.dart';
import 'bottom_bar_view.dart';
import '../models/tabIcon_data.dart';
import 'keep_accounts_them.dart';
import 'overview/this_month_overview_screen.dart';

class KeepAccountsHomeScreen extends StatefulWidget {
  const KeepAccountsHomeScreen({Key? key}) : super(key: key);

  @override
  _KeepAccountsHomeScreenState createState() => _KeepAccountsHomeScreenState();
}

class _KeepAccountsHomeScreenState extends State<KeepAccountsHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  final List<TabIconData> _tabIconsList = TabIconData.tabIconsList;

  Widget _tabBody = Container(
    color: KeepAccountsTheme.background,
  );

  @override
  void initState() {
    for (var tab in _tabIconsList) {
      tab.isSelected = false;
    }
    _tabIconsList[0].isSelected = true;

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _tabBody =
        ThisMonthOverviewScreen(animationController: _animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KeepAccountsTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  _tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: _tabIconsList,
          addClick: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => RecordTransactionScreen(),
              ),
            );
          },
          changeIndex: (int index) {
            if (index == 0) {
              _animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _tabBody = ThisMonthOverviewScreen(
                      animationController: _animationController);
                });
              });
            } else if (index == 1) {
              _animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _tabBody = AccountsManageScreen(
                      animationController: _animationController);
                });
              });
            } else if (index == 2) {
              _animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _tabBody = StatisticsScreen(
                      animationController: _animationController);
                });
              });
            } else if (index == 3) {
              _animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _tabBody = StatisticsScreen(
                      animationController: _animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
