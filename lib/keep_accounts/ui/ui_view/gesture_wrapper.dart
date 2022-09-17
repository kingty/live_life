import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/ui/keep_accounts_them.dart';

class GestureWrapper extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;

  const GestureWrapper({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.grey.withOpacity(0.1),
            highlightColor: Colors.transparent,
            onTap: () {
              onTap?.call();
            },
            child: child));
  }
}

class IconButtonWithInk extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Icon child;
  final Color color;
  final double size;

  const IconButtonWithInk(
      {super.key,
      this.onTap,
      required this.child,
      this.color = Colors.transparent,
      this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Ink(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(size)),
            ),
            child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(size)),
                onTap: () {
                  onTap?.call();
                },
                child: child)));
  }
}
