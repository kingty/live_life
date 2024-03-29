import 'package:flutter/material.dart';
import '../../../icons/custom_icons.dart';

class CategoryIconView extends StatefulWidget {
  const CategoryIconView(
      {Key? key,
      this.iconData = CustomIcons.food_knife_fork,
      this.color = Colors.grey,
      this.size = 20,
      this.index = 0,
      this.selectIndex = 0,
      this.padding = const EdgeInsets.all(12)})
      : super(key: key);

  final IconData iconData;
  final Color color;
  final double size;
  final int index;
  final int selectIndex;
  final EdgeInsetsGeometry padding;

  @override
  _CategoryIconViewState createState() => _CategoryIconViewState();
}

class _CategoryIconViewState extends State<CategoryIconView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (widget.index == widget.selectIndex ? widget.color : Colors.grey)
            .withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: widget.padding,
        child: Icon(
          widget.iconData,
          color:
              widget.index == widget.selectIndex ? widget.color : Colors.grey,
          size: widget.size,
        ),
      ),
    );
  }
}
