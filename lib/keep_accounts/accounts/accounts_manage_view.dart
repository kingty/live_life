import 'package:flutter/material.dart';
import 'package:live_life/common_view/common_app_bar.dart';
import 'package:live_life/keep_accounts/keep_accounts_them.dart';

import '../../common_view/list/src/sliver_expandable_list.dart';
import '../models/mock_data.dart';

class AccountsManageView extends StatefulWidget {
  @override
  _AccountsManageViewState createState() => _AccountsManageViewState();
}

class _AccountsManageViewState extends State<AccountsManageView>
    with TickerProviderStateMixin {
  var sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: "资产管理", slivers: [
      SliverExpandableList(
        builder: SliverExpandableChildDelegate<String, ExampleSection>(
          sectionList: sectionList,
          headerBuilder: _buildHeader,
          itemBuilder: (context, sectionIndex, itemIndex, index) {
            String item = sectionList[sectionIndex].items[itemIndex];
            return ListTile(
              leading: CircleAvatar(
                child: Text("$index"),
              ),
              title: Text(item),
            );
          },
        ),
      )
    ], actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
        color: KeepAccountsTheme.pink,
      ),
      const SizedBox(width: 10,),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_horiz),
        color: KeepAccountsTheme.nearlyDarkBlue,
      )
    ]);
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    ExampleSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: Colors.lightBlue,
            height: 48,
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              section.header,
              style: const TextStyle(color: Colors.white),
            )),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }
}
