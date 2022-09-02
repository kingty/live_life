import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/record_transaction/tag_icon_view.dart';

import '../keep_accounts_them.dart';

class IconTagListView extends StatelessWidget {
  const IconTagListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KeepAccountsTheme.background,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: Row(
        children: const [
          TagIconView(
            iconData: Icons.account_balance_wallet_sharp,
            text: '默认账本',
          ),

          SizedBox(width: 10), // 50宽度
          TagIconView(
            iconData: Icons.calendar_today,
            text: '今天',
          ),

          SizedBox(width: 10), // 50宽度
          TagIconView(
            iconData: Icons.tag,
            text: '标签',
          ),
        ],
      ),
    );
  }
}
