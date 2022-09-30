import 'package:flutter/cupertino.dart';
import 'package:live_life/keep_accounts/ui/ui_view/transaction_list_view.dart';

import '../../../common_view/common_app_bar.dart';
import '../../models/transaction_data.dart';

class TransactionListScreen extends StatelessWidget {
  final List<TransactionData> transactions;
  final String title;

  const TransactionListScreen(
      {super.key, required this.transactions, required this.title});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: title,
      slivers: [
        SliverPadding(
            padding: EdgeInsets.only(
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            sliver: TransactionListView(
                sectionList: MonthSection.getMonthSections(transactions)))
      ],
    );
  }
}
