import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../keep_accounts_them.dart';

class CustomDatePickerView extends StatefulWidget {
  const CustomDatePickerView(
      {super.key,
      required this.specialDates,
      this.onViewChanged,
      this.onSelectionChanged,
      required this.controller});

  @override
  _CustomDatePickerViewState createState() => _CustomDatePickerViewState();
  final List<DateTime> specialDates;
  final DateRangePickerViewChangedCallback? onViewChanged;
  final DateRangePickerSelectionChangedCallback? onSelectionChanged;
  final DateRangePickerController controller;
}

class _CustomDatePickerViewState extends State<CustomDatePickerView>
    with TickerProviderStateMixin {
  final Color monthCellBackground = const Color(0xfff7f4ff);
  final Color indicatorColor = const Color(0xFF1AC4C7);
  final Color highlightColor = Colors.deepPurpleAccent;
  final Color cellTextColor = const Color(0xFF130438);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget datePicker = Container(
        decoration: BoxDecoration(
          color: KeepAccountsTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: KeepAccountsTheme.grey.withOpacity(0.01),
                offset: const Offset(0.0, 5.0),
                blurRadius: 5.0),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: _getCustomizedDatePicker());
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
        child: Localizations(
          locale: const Locale('zh', 'CN'),
          delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          child: datePicker,
        ));
  }

  /// Returns the date range picker based on the properties passed
  SfDateRangePicker _getCustomizedDatePicker() {
    return SfDateRangePicker(
      controller: widget.controller,
      onViewChanged: (DateRangePickerViewChangedArgs args) {
        widget.onViewChanged?.call(args);
      },
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        widget.onSelectionChanged?.call(args);
      },
      view: DateRangePickerView.month,
      allowViewNavigation: widget.controller.view == DateRangePickerView.month,
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: highlightColor,
      selectionTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      headerStyle: DateRangePickerHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 18,
            color: cellTextColor,
          )),
      monthCellStyle: DateRangePickerMonthCellStyle(
          todayCellDecoration: _MonthCellDecoration(
              borderColor: highlightColor,
              backgroundColor: monthCellBackground,
              showIndicator: false,
              indicatorColor: indicatorColor),
          specialDatesDecoration: _MonthCellDecoration(
              backgroundColor: monthCellBackground,
              showIndicator: true,
              indicatorColor: indicatorColor),
          disabledDatesTextStyle: const TextStyle(
            color: Color(0xffe2d7fe),
          ),
          weekendTextStyle: TextStyle(
            color: highlightColor,
          ),
          textStyle: TextStyle(color: cellTextColor, fontSize: 14),
          // specialDatesTextStyle: TextStyle(color: cellTextColor, fontSize: 14),
          todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)),
      yearCellStyle: DateRangePickerYearCellStyle(
        todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
        textStyle: TextStyle(color: cellTextColor, fontSize: 14),
        disabledDatesTextStyle: TextStyle(color: const Color(0xffe2d7fe)),
        leadingDatesTextStyle:
            TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
      ),
      showNavigationArrow: true,
      todayHighlightColor: highlightColor,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
                fontSize: 10,
                color: cellTextColor,
                fontWeight: FontWeight.w600)),
        dayFormat: 'EEE',
        specialDates: widget.specialDates,
      ),
    );
  }
}

class _MonthCellDecoration extends Decoration {
  const _MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor!;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor!;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    }

    if (showIndicator) {
      paint.color = indicatorColor!;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}
