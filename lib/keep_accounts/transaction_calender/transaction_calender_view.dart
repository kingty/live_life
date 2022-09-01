import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_view/common_app_bar.dart';
import '../../generated/l10n.dart';
import '../../helper.dart';
import '../accounts/asset_management_overview_view.dart';
import '../keep_accounts_them.dart';
import '../models/mock_data.dart';
import '../models/transaction_data.dart';
import '../ui_view/transaction_list_view.dart';
import 'custom_date_picker_view.dart';

class TransactionCalenderView extends StatefulWidget {
  @override
  _TransactionCalenderViewState createState() =>
      _TransactionCalenderViewState();
}

class _TransactionCalenderViewState extends State<TransactionCalenderView>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    listViews.add(CustomDatePickerView());
    super.initState();
  }

  Future<List<TransactionData>> getData() async {
    var section = await MockData.getTransactions();
    return section;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionData>>(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TransactionData>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return CommonAppBar(
              title: S.current.KEEP_ACCOUNTS_TRANSACTION_CALENDER,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return listViews[index];
                }, childCount: listViews.length)),
                TransactionListView(
                    sectionList:
                        MonthSection.getMonthSections(snapshot.requireData))
              ],
              actions: [
                IconButton(
                  onPressed: () {
                    showBottomSheetSettingsPanel(context, SizedBox(height:400, child: listViews[0],));
                  },
                  icon: const Icon(Icons.filter_list_outlined),
                  color: KeepAccountsTheme.nearlyDarkBlue,
                ),
                const SizedBox(
                  width: 10,
                ),
              ]);
        }
      },
    );
  }
}
