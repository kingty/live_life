import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';
import 'package:live_life/keep_accounts/ui/statistics/statistics_base_animator_view.dart';

class StatisticsTimeSelectView extends StatelessWidget {
  final AnimationController animationController;
  final int index;

  const StatisticsTimeSelectView(
      {Key? key, required this.animationController, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatisticsBaseAnimatorView(
      animationController: animationController,
      index: index,
      innerWidget: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: KeepAccountsTheme.nearlyDarkBlue,
                )),
            const Expanded(
                child: Text(
              '2022 年 6月',
              textAlign: TextAlign.center,
              style: KeepAccountsTheme.subtitle,
            )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: KeepAccountsTheme.nearlyDarkBlue,
                ))
          ],
        ),
      ),
    );
  }
}
