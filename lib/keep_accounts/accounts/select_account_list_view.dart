import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/accounts/select_account_item_view.dart';
import 'package:live_life/keep_accounts/models/bank_data.dart';

import '../../common_view/common_app_bar.dart';
import '../../common_view/list/src/sliver_expandable_list.dart';
import '../../common_view/search_input_view.dart';
import '../../generated/l10n.dart';
import '../keep_accounts_them.dart';

class SelectAccountListView extends StatefulWidget {
  @override
  _SelectAccountListViewState createState() => _SelectAccountListViewState();
}

class _SelectAccountListViewState extends State<SelectAccountListView>
    with TickerProviderStateMixin {
  List<AccountSection> sectionList = AccountSection.getAccountSections();

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: S.current.KEEP_ACCOUNTS_ADD_ACCOUNT, slivers: [
      SliverPersistentHeader(
        pinned: true,
        delegate: _PersistentHeaderDelegate(),
      ),
      SliverExpandableList(
        builder: SliverExpandableChildDelegate<BankData, AccountSection>(
          sectionList: sectionList,
          headerBuilder: _buildHeader,
          itemBuilder: (context, sectionIndex, itemIndex, index) {
            var item = sectionList[sectionIndex].items[itemIndex];

            return SelectAccountItemView(data: item);
          },
        ),
      )
    ]);
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    AccountSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: KeepAccountsTheme.background,
            height: 48,
            padding: const EdgeInsets.only(left: 24),
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: section.groupName,
                  style: const TextStyle(
                      color: KeepAccountsTheme.dark_grey, fontSize: 16)),
              WidgetSpan(
                child: Icon(
                  section.expanded
                      ? Icons.arrow_drop_down_outlined
                      : Icons.arrow_right_outlined,
                  size: 16,
                  color: KeepAccountsTheme.dark_grey,
                ),
              ),
            ]))),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }
}

/// Search bar
class _PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PersistentHeaderDelegate() {}

  // SampleModel? _sampleListModel;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: 60,
      child: Container(
          alignment: Alignment.center,
          color: KeepAccountsTheme.background,
          child: const SearchInputView()),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(_PersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class AccountSection implements ExpandableListSection<BankData> {
  //store expand state.
  late bool expanded;

  late List<BankData> items;

  late String groupName;

  @override
  List<BankData> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }

  static List<AccountSection> getAccountSections() {
    var sections = List<AccountSection>.empty(growable: true);

    sections.add(AccountSection()
      ..groupName = "互联网账户"
      ..expanded = true
      ..items = BankData.network.values.toList());
    sections.add(AccountSection()
      ..groupName = "国有大型商业银行"
      ..expanded = true
      ..items = BankData.gydxsyyh.values.toList());
    sections.add(AccountSection()
      ..groupName = "股份制商业银行"
      ..expanded = true
      ..items = BankData.gfzsyyh.values.toList());
    sections.add(AccountSection()
      ..groupName = "城市商业银行"
      ..expanded = true
      ..items = BankData.cssyyh.values.toList());
    sections.add(AccountSection()
      ..groupName = "外资法人银行"
      ..expanded = true
      ..items = BankData.wzfryh.values.toList());

    return sections;
  }
}
