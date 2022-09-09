import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../keep_accounts_them.dart';

class NumberKeyboardView extends StatelessWidget {
  const NumberKeyboardView(
      {Key? key, required this.mainColor, required this.calculator, this.onSubmit})
      : super(key: key);
  final Color mainColor;
  final Calculator calculator;
  final ValueChanged<double>? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: KeepAccountsTheme.grey.withOpacity(0.1),
        height: 250,
        child: Column(
          children: [
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(width: 2),
                NumberView(
                  calculator: calculator,
                  button: Button.One,
                ),
                const SizedBox(width: 4),
                NumberView(
                  calculator: calculator,
                  button: Button.Two,
                ),
                const SizedBox(width: 4),
                NumberView(
                  calculator: calculator,
                  button: Button.Three,
                ),
                const SizedBox(width: 4),
                DeleteView(
                  calculator: calculator,
                  color: mainColor,
                ),
                const SizedBox(width: 2),
              ],
            ),
            const SizedBox(height: 4),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 2),
                  NumberView(
                    calculator: calculator,
                    button: Button.Four,
                  ),
                  const SizedBox(width: 4),
                  NumberView(
                    calculator: calculator,
                    button: Button.Five,
                  ),
                  const SizedBox(width: 4),
                  NumberView(
                    calculator: calculator,
                    button: Button.Six,
                  ),
                  const SizedBox(width: 4),
                  NumberView(
                    calculator: calculator,
                    button: Button.Plus,
                  ),
                  const SizedBox(width: 2),
                ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 3,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(width: 2),
                        NumberView(
                          calculator: calculator,
                          button: Button.Seven,
                        ),
                        const SizedBox(width: 4),
                        NumberView(
                          calculator: calculator,
                          button: Button.Eight,
                        ),
                        const SizedBox(width: 4),
                        NumberView(
                          calculator: calculator,
                          button: Button.Nine,
                        )
                      ]),
                  const SizedBox(height: 4),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(width: 2),
                        NumberView(
                          calculator: calculator,
                          button: Button.Minus,
                        ),
                        const SizedBox(width: 4),
                        NumberView(
                          calculator: calculator,
                          button: Button.Zero,
                        ),
                        const SizedBox(width: 4),
                        NumberView(
                          calculator: calculator,
                          button: Button.Dot,
                        )
                      ]),
                ]),
              ),
              const SizedBox(width: 3),
              Expanded(
                  child: Row(
                children: [
                  const SizedBox(width: 1),
                  DoneView(
                    calculator: calculator,
                    color: mainColor,
                    onSubmit: onSubmit,
                  ),
                  const SizedBox(width: 2),
                ],
              )),
            ])
          ],
        ));
  }
}

class NumberView extends StatelessWidget {
  final Button button;
  final Color color;
  final Calculator calculator;

  const NumberView(
      {super.key,
      required this.button,
      this.color = KeepAccountsTheme.grey,
      required this.calculator});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Material(
            color: Colors.transparent,
            child: Ink(
                decoration: const BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: InkWell(
                    // highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    onTap: () {
                      calculator.whenClick(button);
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 4),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          button.label,
                          style: TextStyle(
                            fontSize: 20,
                            height: 0.9,
                            color: color,
                          ),
                        ))))));
  }
}

class DoneView extends StatefulWidget {
  final Color color;
  final Calculator calculator;
  final ValueChanged<double>? onSubmit;
  const DoneView(
      {super.key,
      this.color = KeepAccountsTheme.grey,
      required this.calculator, this.onSubmit});

  @override
  _DoneViewState createState() => _DoneViewState();
}

class _DoneViewState extends State<DoneView> {
  bool hasCalculateOperator = false;
  @override
  void initState() {
    widget.calculator.stream().listen((event) {
      setState(() {
        hasCalculateOperator = widget.calculator.hasCalculateOperator();
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Material(
            color: Colors.transparent,
            child: Ink(
                decoration: const BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: InkWell(
                    // highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    onTap: () {
                      if(hasCalculateOperator) {
                        widget.calculator.whenClick(Button.Done);
                      } else {
                        widget.onSubmit?.call(widget.calculator.getLastResult());
                      }
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 4),
                        height: 108,
                        alignment: Alignment.center,
                        child: Text(
                          hasCalculateOperator ? Button.Done.label : "完成",
                          style: TextStyle(
                            fontSize: 20,
                            height: 0.9,
                            color: widget.color,
                          ),
                        ))))));
  }
}

class DeleteView extends StatelessWidget {
  const DeleteView(
      {super.key,
      this.color = KeepAccountsTheme.grey,
      required this.calculator});

  final Color color;
  final Calculator calculator;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Material(
            color: Colors.transparent,
            child: Ink(
                decoration: const BoxDecoration(
                  color: KeepAccountsTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: InkWell(
                    // highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    onTap: () {
                      calculator.whenClick(Button.Delete);
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 4),
                        height: 50,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.backspace_sharp,
                          color: color,
                        ))))));
  }
}

enum Button{
  Zero(label: "0", isOperator: false),
  One(label: "1", isOperator: false),
  Two(label: "2", isOperator: false),
  Three(label: "3", isOperator: false),
  Four(label: "4", isOperator: false),
  Five(label: "5", isOperator: false),
  Six(label: "6", isOperator: false),
  Seven(label: "7", isOperator: false),
  Eight(label: "8", isOperator: false),
  Nine(label: "9", isOperator: false),
  Dot(label: ".", isOperator: false),
  Plus(label: "+", isOperator: true),
  Minus(label: "-", isOperator: true),
  Delete(label: "delete", isOperator: true),
  Done(label: "=", isOperator: true);

  final String label;
  final bool isOperator;

  const Button({
    required this.label,
    required this.isOperator,
  });

static Button parse(String lable) {
    Button btn = Button.Done;
    switch (lable) {
      case "0":
        return Button.Zero;
      case "1":
        return Button.One;
      case "2":
        return Button.Two;
      case "3":
        return Button.Three;
      case "4":
        return Button.Four;
      case "5":
        return Button.Five;
      case "6":
        return Button.Six;
      case "7":
        return Button.Seven;
      case "8":
        return Button.Eight;
      case "9":
        return Button.Nine;
      case ".":
        return Button.Dot;
      case "+":
        return Button.Plus;
      case "-":
        return Button.Minus;
      case "=":
        return Button.Done;
      case "delete":
        return Button.Delete;
    }
    return btn;
  }
}

class Calculator {
  final List<Button> _inputBtns = List.empty(growable: true);
  double _lastResult = 0.0;

  void clear() {
    _inputBtns.clear();
    _lastResult = 0.0;
    _result.add("");
  }

  double _calculate() {
    double x = 0;
    double y = 0;
    String d = "";
    Queue<double> digitals = Queue();
    Queue<Button> operator = Queue();

    if (kDebugMode) {
      print(_inputBtns);
      print(d);
    }
    for (var element in _inputBtns) {
      if (element.isOperator) {
        if (d.isEmpty) {
          digitals.add(0);
        } else {
          digitals.add(double.parse(d));
        }
        d = "";
        operator.add(element);
      } else {
        d = d + element.label;
      }
    }
    if (d.isEmpty) {
      digitals.add(0);
    } else {
      digitals.add(double.parse(d));
    }

    x = digitals.removeFirst();
    while (digitals.isNotEmpty) {
      y = digitals.removeFirst();
      var op = operator.removeFirst();
      if (op == Button.Plus) x = double.parse((x + y).toStringAsFixed(2));
      if (op == Button.Minus) x = double.parse((x - y).toStringAsFixed(2));
    }
    _inputBtns.clear();
    _inputBtns.addAll(x.toStringAsFixed(2).characters.map((e) => Button.parse(e)));
    _lastResult = x;
    return x;
  }


  bool _hasDotInLastDigit() {
    for (var element in _inputBtns.reversed) {
      if (element == Button.Dot) return true;
      if (element ==  Button.Plus ||
          element == Button.Minus) return false;
    }
    return false;
  }

  bool hasCalculateOperator() {
    for (var element in _inputBtns.reversed) {
      if (element ==  Button.Plus ||
          element == Button.Minus) return true;
    }
    return false;
  }

  void whenClick(Button event) {
    if (event.isOperator) {
      switch (event) {
        case Button.Plus:
        case Button.Minus:
          // 如果在加减号后接加减号的话，直接删除之前的
          if (_inputBtns.isNotEmpty &&
              (_inputBtns.last == Button.Plus ||
                  _inputBtns.last == Button.Minus ||
                  _inputBtns.last == Button.Dot)) {
            _inputBtns.removeLast();
          }
          _inputBtns.add(event);
          break;
        case Button.Delete:
          if (_inputBtns.isNotEmpty) {
            _inputBtns.removeLast();
          }
          break;
        case Button.Done:
          _calculate();
          break;
        default:
      }
    } else {
      if (event == Button.Dot) {
        // 如果是. ，会有几种情况
        // 1是在符号后面接 . 或者直接输入 . ,转换成0.xxx
        if ((_inputBtns.isNotEmpty &&
            (_inputBtns.last == Button.Plus ||
                _inputBtns.last == Button.Minus)) || _inputBtns.isEmpty) {
          _inputBtns.add(Button.Zero);
          _inputBtns.add(Button.Dot);
        }
        // 2.是最后一个数字已经有. 了，那么不再输入

        if (_hasDotInLastDigit()) {
          // do nothing
        } else {
          _inputBtns.add(Button.Dot);
        }
      } else {
        _inputBtns.add(event);
      }
    }

    _result.add(_inputBtns.map((e) => e.label).toList().join());
  }

  final PublishSubject<String> _result = PublishSubject();

  Stream stream() {
    return _result.stream;
  }

  double getLastResult() {
    if (_inputBtns.isNotEmpty && _inputBtns.last == Button.Dot) {
      _inputBtns.removeLast();
    }
    if (_inputBtns.isEmpty)  return 0;
    var d = double.parse(_inputBtns.map((e) => e.label).toList().join());
    return double.parse(d.toStringAsFixed(2));
  }
}
