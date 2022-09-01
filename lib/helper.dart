

import 'package:flutter/material.dart';
import 'package:live_life/app_theme.dart';

import 'common_view/bottom_sheet.dart';

///To show the settings panel content in the bottom sheet
void showBottomSheetSettingsPanel(BuildContext context, Widget propertyWidget) {
  showRoundedModalBottomSheet<dynamic>(
      context: context,
      color: AppTheme.background,
      builder: (BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Stack(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('筛选',
                  style: TextStyle(
                      color: AppTheme.darkerText,
                      fontSize: 18,
                      letterSpacing: 0.34,
                      fontWeight: FontWeight.w500)),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppTheme.darkerText,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Theme(
              data: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: AppTheme.background,
                  colorScheme: const ColorScheme.light()),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: propertyWidget))
        ]),
      ));
}