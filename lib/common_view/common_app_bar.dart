import 'package:flutter/material.dart';
import 'package:live_life/app_theme.dart';

class CommonAppBar extends StatefulWidget {
  CommonAppBar(
      {Key? key,
      this.actions,
      required this.title,
      this.subTitle,
      required this.slivers})
      : super(key: key);

  final String title;
  String? subTitle;
  List<Widget>? actions;
  final List<Widget> slivers;

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar>
    with TickerProviderStateMixin {
  final ScrollController controller = ScrollController();

  var color = AppTheme.darkerText;

  List<Widget> _getAllSlivers() {
    final List<Widget> allSlivers = List.empty(growable: true);
    allSlivers.add(SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: Text(widget.title,
              style: TextStyle(
                  color: color,
                  fontSize: 30,
                  letterSpacing: 0.53,
                  fontFamily: 'HeeboBold',
                  fontWeight: FontWeight.bold)),
        ),
        Container(
            height: 4,
            width: 30,
            margin: const EdgeInsets.only(bottom: 5, left: 24),
            decoration: const BoxDecoration(
              color: AppTheme.pink,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: _sampleListModel!.webBackgroundColor,
              //     offset: const Offset(0, 2.0),
              //     blurRadius: 0.25,
              //   )
              // ]
            )),
        Visibility(
            visible: widget.subTitle != null,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 0, 5),
                child: Text(widget.subTitle ?? "",
                    style: TextStyle(
                        color: color.withOpacity(0.7),
                        fontSize: 14,
                        letterSpacing: 0.26,
                        fontFamily: 'HeeboBold',
                        fontWeight: FontWeight.normal))))
      ],
    )));
    for (var w in widget.slivers) {
      allSlivers.add(w);
    }

    return allSlivers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          leading: IconButton(
            color: AppTheme.nearlyDarkBlue,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          backgroundColor: AppTheme.background,
          title: AnimateOpacityWidget(
              controller: controller,
              opacity: 0,
              child: Text(widget.title,
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'HeeboMedium', color: color))),
          actions: widget.actions,
        ),
        body: Container(
            color: AppTheme.background,
            transform: Matrix4.translationValues(0, -1, 0),
            child: GlowingOverscrollIndicator(
                color: AppTheme.background,
                axisDirection: AxisDirection.down,
                child: CustomScrollView(
                  controller: controller,
                  physics: const ClampingScrollPhysics(),
                  slivers: _getAllSlivers(),
                ))));
  }
}

/// Creates a widget that makes its child partially transparent.
class AnimateOpacityWidget extends StatefulWidget {
  /// Holds custom opacity widget information
  // ignore: tighten_type_of_initializing_formals
  const AnimateOpacityWidget({this.opacity, this.child, this.controller})
      : assert(opacity != null),
        assert(child != null);

  /// The fraction to scale the child's alpha value.
  final double? opacity;

  /// Creates a widget that makes its child partially transparent.
  final Widget? child;

  ///[controller] Controls a scrollable widget.
  final ScrollController? controller;

  @override
  _AnimateOpacityWidgetState createState() => _AnimateOpacityWidgetState();
}

class _AnimateOpacityWidgetState extends State<AnimateOpacityWidget> {
  late double? _opacity;

  @override
  void initState() {
    _opacity = widget.opacity;
    widget.controller!.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final double opacity = widget.controller!.offset * 0.01;
    if (opacity >= 0 && opacity <= 1) {
      setState(() {
        _opacity = opacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _opacity!, child: widget.child);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller!.removeListener(_onScroll);
  }
}
