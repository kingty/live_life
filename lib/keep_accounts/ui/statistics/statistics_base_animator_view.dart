import 'package:flutter/cupertino.dart';

abstract class StatisticsBaseAnimatorView extends StatelessWidget {
  final AnimationController animationController;
  final int index;

  const StatisticsBaseAnimatorView(
      {Key? key, required this.animationController, required this.index})
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

  const StatisticsBaseAnimatorStatefulView(
      {Key? key, required this.animationController, required this.index})
      : super(key: key);
}

abstract class StatisticsBaseAnimatorStatefulViewState
    extends State<StatisticsBaseAnimatorStatefulView>
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
