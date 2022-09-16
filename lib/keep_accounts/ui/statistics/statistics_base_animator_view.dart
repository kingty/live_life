import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

abstract class StatisticsBaseAnimatorView extends StatelessWidget {
  final AnimationController animationController;
  final int index;
  final DateRangePickerView mode;

  const StatisticsBaseAnimatorView(
      {Key? key, required this.animationController, required this.index, required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexA = index > 9 ? 9 : index;
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / 9) * indexA, 1.0, curve: Curves.fastOutSlowIn)));
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: buildInnerWidget()));
        });
  }

  Widget buildInnerWidget();
}

abstract class StatisticsBaseAnimatorStatefulView extends StatefulWidget {
  final AnimationController animationController;
  final int index;
  final DateRangePickerView mode;

  const StatisticsBaseAnimatorStatefulView(
      {Key? key, required this.animationController, required this.index, required this.mode})
      : super(key: key);
}

abstract class StatisticsBaseAnimatorStatefulViewState<T extends StatisticsBaseAnimatorStatefulView>
    extends State<T>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var indexA = widget.index > 9 ? 9 : widget.index;
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / 9) * indexA, 1.0, curve: Curves.fastOutSlowIn)));
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: buildInnerWidget()));
        });
  }

  Widget buildInnerWidget();
}
