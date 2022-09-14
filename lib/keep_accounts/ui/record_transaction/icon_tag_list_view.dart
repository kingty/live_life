import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/tag_data.dart';
import 'package:live_life/keep_accounts/ui/record_transaction/tag_icon_view.dart';

import '../../../common_view/date_picker_dialog.dart';
import '../../../helper.dart';
import '../../control/middle_ware.dart';
import '../keep_accounts_them.dart';
import '../../models/transaction_data.dart';

class IconTagListView extends StatefulWidget {
  const IconTagListView(
      {super.key, required this.mainColor, required this.transactionData});

  final Color mainColor;
  final TransactionData transactionData;

  @override
  _IconTagListViewState createState() => _IconTagListViewState();
}

class _IconTagListViewState extends State<IconTagListView> {
  var _tranTime = DateTime.now();
  int _selectTagIndex = -1;
  late List<TagData> _tags;

  @override
  void initState() {
    widget.transactionData.tranTime = _tranTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TagData>>(
        stream: MiddleWare.instance.tag.getTagsStream(),
        builder: (BuildContext context, AsyncSnapshot<List<TagData>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            _tags = snapshot.data!;
            return buildWhenGetData();
          }
        });
  }

  Widget buildWhenGetData() {
    return Container(
      height: 40,
      color: KeepAccountsTheme.background,
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          TagIconView(
            iconData: Icons.calendar_today,
            text: calculateDifference(_tranTime) == 0
                ? '今天'
                : formatTime(_tranTime),
            onTap: () async {
              final DateTime? date = await showDialog<DateTime?>(
                  context: context,
                  builder: (BuildContext context) {
                    return DateRangePickerDlg(
                      _tranTime,
                      null,
                      displayDate: _tranTime,
                    );
                  });
              if (date != null) {
                setState(() {
                  _tranTime = date;
                  widget.transactionData.tranTime = _tranTime;
                });
              }
            },
          ),
          const SizedBox(width: 15),
          TagIconView(
            iconData: Icons.tag_rounded,
            text: _selectTagIndex >= 0
                ? '标签-${_tags[_selectTagIndex].name}'
                : '标签',
            onTap: () {
              showBottomSheetPanel(
                  context, SizedBox(height: 400, child: _getTagsList()));
            },
          ),
        ],
      ),
    );
  }

  Widget _getTagsList() {
    if (_tags.isEmpty) {
      return Container(
        alignment: Alignment.center,
        height: 200,
        child: const Text(
          '还没有标签,请添加自定义的标签.',
          style: KeepAccountsTheme.subtitle,
        ),
      );
    }
    return ListView.separated(
      itemCount: _tags.length,
      itemBuilder: (BuildContext context, int index) {
        var tag = _tags[index];
        return InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectTagIndex = index;
              widget.transactionData.tagId = tag.id;
            });
          },
          child: Container(
              height: 60,
              width: double.infinity,
              decoration: (_selectTagIndex == index)
                  ? BoxDecoration(
                      color: widget.mainColor.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    )
                  : null,
              margin: const EdgeInsets.only(left: 14, right: 14),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: Row(children: [
                Icon(Icons.tag_rounded, color: widget.mainColor),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    tag.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: KeepAccountsTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: -0.1,
                      color: KeepAccountsTheme.nearlyBlack.withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text("(${tag.des})",
                        overflow: TextOverflow.ellipsis,
                        style: KeepAccountsTheme.smallDetail))
              ])),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.black12.withOpacity(0.05),
          indent: 12,
          endIndent: 12,
        );
      },
    );
  }
}
