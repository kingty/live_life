import 'package:flutter/material.dart';

/// 自定义Tab指示器样式
/// 支持自定义指示器宽度
/// DIY (1) 指示器自定义
/// DIY (2) 指示器颜色跟随页面自定义
class MagicTabIndicator extends Decoration {
  const MagicTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.width = 30,
    required this.labelColors,
    required this.pageController,
  })  : assert(borderSide != null),
        assert(insets != null);

  final BorderSide borderSide;

  final EdgeInsetsGeometry insets;

  final double width;
  final TabController pageController;

  final List<Color> labelColors;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is MagicTabIndicator) {
      return MagicTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
        labelColors: a.labelColors,
        pageController: a.pageController,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is MagicTabIndicator) {
      return MagicTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
        labelColors: b.labelColors,
        pageController: b.pageController,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);


    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double midValue = (indicator.right - indicator.left) / 2 + indicator.left;
    return Rect.fromLTWH(
      midValue - width / 2,
      indicator.bottom - borderSide.width,
      width,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : assert(decoration != null),
        super(onChanged);

  final MagicTabIndicator decoration;

  TabController get pageController => decoration.pageController;

  List<Color> get labelColors => decoration.labelColors;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    // Animation<double> colorAnimation = _ChangeAnimation(pageController);

    // final Rect rect = offset & configuration.size!;
    // final TextDirection textDirection = configuration.textDirection!;
    // final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    // final Paint paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.square;
    // canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);

    /// DIY(2) step 1
    double page = 0;
    int realPage = 0;
    page = pageController.index + pageController.offset;
    realPage = pageController.index + pageController.offset.floor();
    double opacity = 1 - (page - realPage).abs();
    Color thisColor = labelColors[realPage];
    thisColor = thisColor;
    Color nextColor = labelColors[
        realPage + 1 < labelColors.length ? realPage + 1 : realPage];
    nextColor = nextColor;

    /// DIY(1) step 1
    final Rect rect = offset & configuration.size!;
    final TextDirection? textDirection = configuration.textDirection;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection!)
        .deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.round

      /// DIY(2) step 2
      ..color = Color.lerp(nextColor, thisColor, opacity)!;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
