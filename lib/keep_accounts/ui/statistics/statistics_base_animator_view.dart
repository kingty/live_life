import 'package:flutter/cupertino.dart';

class StatisticsBaseAnimatorView extends StatelessWidget {
  final AnimationController animationController;
  final Widget innerWidget;
  final int index;

  const StatisticsBaseAnimatorView(
      {Key? key,
      required this.animationController,
      required this.innerWidget,
      required this.index})
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
                  child: innerWidget));
        });
  }
}
