import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/models/mock_data.dart';
import 'package:live_life/keep_accounts/record_transaction/tag_icon_view.dart';

import '../../common_view/date_picker_dialog.dart';
import '../../helper.dart';
import '../keep_accounts_them.dart';

class IconTagListView extends StatefulWidget {
  const IconTagListView({super.key, required this.mainColor});

  final Color mainColor;

  @override
  _IconTagListViewState createState() => _IconTagListViewState();
}

class _IconTagListViewState extends State<IconTagListView> {
  var _recordTime = DateTime.now();
  int selectTagIndex = -1;
  var tags = MockData.getTags();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: KeepAccountsTheme.background,
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          TagIconView(
            iconData: Icons.calendar_today,
            text: calculateDifference(_recordTime) == 0
                ? '今天'
                : formatTime(_recordTime),
            onTap: () async {
              final DateTime? date = await showDialog<DateTime?>(
                  context: context,
                  builder: (BuildContext context) {
                    return DateRangePickerDlg(
                      _recordTime,
                      null,
                      displayDate: _recordTime,
                    );
                  });
              if (date != null) {
                setState(() {
                  _recordTime = date;
                });
              }
            },
          ),
          const SizedBox(width: 15),
          TagIconView(
            iconData: Icons.tag_rounded,
            text: '标签',
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
    return ListView.separated(
      itemCount: tags.length,
      itemBuilder: (BuildContext context, int index) {
        var tag = tags[index];
        return InkWell(
          onTap: () {
            Navigator.pop(context);
            selectTagIndex = index;
          },
          child: Container(
              height: 60,
              width: double.infinity,
              decoration: (selectTagIndex == index)
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
