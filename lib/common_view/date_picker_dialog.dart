import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as picker;

import '../helper.dart';

/// Builds the date range picker inside a pop-up based on the properties passed,
/// and return the selected date or range based on the tripe mode selected.
class DateRangePickerDlg extends StatefulWidget {
  /// Creates Date range picker
  const DateRangePickerDlg(this.date, this.range,
      {this.minDate, this.maxDate, this.displayDate});

  /// Holds date value
  final dynamic date;

  /// Holds date range value
  final dynamic range;

  /// Holds minimum date value
  final dynamic minDate;

  /// Holds maximum date value
  final dynamic maxDate;

  /// Holds showable date value
  final dynamic displayDate;

  @override
  State<StatefulWidget> createState() {
    return _DateRangePickerDialogState();
  }
}

class _DateRangePickerDialogState extends State<DateRangePickerDlg> {
  dynamic _date;
  dynamic _controller;
  dynamic _range;
  final Color _textColor = const Color.fromRGBO(51, 51, 51, 1);
  final Color _backgroundColor = const Color.fromRGBO(0, 116, 227, 1);
  final Color _cardThemeColor = Colors.white;

  @override
  void initState() {
    _date = widget.date;
    _range = widget.range;
    _controller = picker.DateRangePickerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget selectedDateWidget = Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _range == null ||
                    _range.startDate == null ||
                    _range.endDate == null ||
                    _range.startDate == _range.endDate
                ? Text(
                    formatTime(_range == null
                        ? _date
                        : (_range.startDate ?? _range.endDate)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _textColor),
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(
                          formatTime(
                              _range.startDate.isAfter(_range.endDate) == true
                                  ? _range.endDate
                                  : _range.startDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _textColor),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          formatTime(
                              _range.startDate.isAfter(_range.endDate) == true
                                  ? _range.startDate
                                  : _range.endDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _textColor),
                        ),
                      ),
                    ],
                  )));

    _controller.selectedDate = _date;
    _controller.selectedRange = _range;
    Widget pickerWidget;

    pickerWidget = picker.SfDateRangePicker(
      controller: _controller,
      initialDisplayDate: widget.displayDate,
      showNavigationArrow: true,
      showActionButtons: true,
      onCancel: () => Navigator.pop(context, null),
      enableMultiView: false,
      selectionMode: _range == null
          ? picker.DateRangePickerSelectionMode.single
          : picker.DateRangePickerSelectionMode.range,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
      todayHighlightColor: Colors.transparent,
      headerStyle: picker.DateRangePickerHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: _backgroundColor, fontSize: 15)),
      onSubmit: (Object? value) {
        if (_range == null) {
          Navigator.pop(context, _date);
        } else {
          Navigator.pop(context, _range);
        }
      },
      onSelectionChanged: (picker.DateRangePickerSelectionChangedArgs details) {
        setState(() {
          if (_range == null) {
            _date = details.value;
          } else {
            _range = details.value;
          }
        });
      },
    );

    return Dialog(
        backgroundColor: _cardThemeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 450,
          width: 350,
          color: _cardThemeColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              selectedDateWidget,
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Localizations(
                        locale: const Locale('zh', 'CN'),
                        delegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate
                        ],
                        child: pickerWidget,
                      ))),
            ],
          ),
        ));
  }
}
