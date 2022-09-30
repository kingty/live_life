import 'package:flutter/material.dart';
import 'package:live_life/app_theme.dart';
import 'package:uuid/uuid.dart';

import 'common_view/bottom_sheet.dart';

class Pair<T, V> {
  Pair(this.first, this.second);

  late T first;
  late V second;

  @override
  String toString() => 'Pair[$first, $second]';
}

///To show the  panel content in the bottom sheet
void showBottomSheetPanel(BuildContext context, Widget propertyWidget) {
  showRoundedModalBottomSheet<dynamic>(
      context: context,
      color: AppTheme.background,
      builder: (BuildContext context) => Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: propertyWidget),
          ));
}

Future<bool?> showAlertDialog(BuildContext context, String content,
    {String title = '提示', VoidCallback? onSure, VoidCallback? onCancel}) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    onPressed: () {
      onCancel?.call();
      Navigator.pop(context, false);
    },
    child: const Text("取消"),
  );
  Widget continueButton = TextButton(
    onPressed: () {
      onSure?.call();
      Navigator.pop(context, true);
    },
    child: const Text("确定"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String formatTime(DateTime time) {
  return ("${time.year}-${time.month}-${time.day}");
}

/// Returns the difference (in full days) between the provided date and today.
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}

var uuid = Uuid();

bool isNumeric(String s) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
  return numericRegex.hasMatch(s);
}

DateTime getDateBegin(DateTime d) => DateTime(d.year, d.month, d.day);

bool isSameDay(DateTime x, DateTime y) {
  if (x.year != y.year) return false;
  if (x.month != y.month) return false;
  if (x.day != y.day) return false;
  return true;
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

String displayMoneyStr(double count) {
  return '¥ ${count.toStringAsFixed(2)}';
}
