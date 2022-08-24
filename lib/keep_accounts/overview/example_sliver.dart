import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/keep_accounts_them.dart';

import '../../common_view/list/src/sliver_expandable_list.dart';
import '../ui_view/transaction_item_view.dart';
import 'mock_data.dart';

class ExampleSliver extends StatefulWidget {
  @override
  _ExampleSliverState createState() => _ExampleSliverState();
}

class _ExampleSliverState extends State<ExampleSliver> {
  var sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KeepAccountsTheme.background,
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              backgroundColor: KeepAccountsTheme.background,
              pinned: true,
              floating: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Sliver Example",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              iconTheme: IconThemeData(color: Colors.blue),
            ),
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<String, ExampleSection>(
                sectionList: sectionList,
                headerBuilder: _buildHeader,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  String item = sectionList[sectionIndex].items[itemIndex];
                  return TransactionItemView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    ExampleSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: KeepAccountsTheme.background,
            height: 48,
            padding: EdgeInsets.only(left: 24),
            alignment: Alignment.centerLeft,
            child: Text(
              section.header,
              style: KeepAccountsTheme.caption,
            )),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }
}
