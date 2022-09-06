import 'package:flutter/material.dart';
import 'package:live_life/app_theme.dart';

import 'common_view/bottom_sheet.dart';

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

String formatTime(DateTime time) {
  return ("${time.year}-${time.month}-${time.day}");
}

/// Returns the difference (in full days) between the provided date and today.
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
}