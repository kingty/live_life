import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/record_transaction/tag_icon_view.dart';

import '../../common_view/date_picker_dialog.dart';
import '../../helper.dart';
import '../keep_accounts_them.dart';

class IconTagListView extends StatefulWidget {
  const IconTagListView({super.key});

  @override
  _IconTagListViewState createState() => _IconTagListViewState();
}

class _IconTagListViewState extends State<IconTagListView> {
  var _recordTime = DateTime.now();

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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
