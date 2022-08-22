import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../icons/custom_icons.dart';
import '../keep_accounts_them.dart';

class CategoryIconView extends StatefulWidget {
  const CategoryIconView({
    Key? key,
    this.iconData = CustomIcons.food_knife_fork,
    this.color = Colors.pink,
    this.size = 20,
  }) : super(key: key);

  final IconData iconData;
  final Color color;
  final double size;

  @override
  _CategoryIconViewState createState() => _CategoryIconViewState();
}

class _CategoryIconViewState extends State<CategoryIconView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KeepAccountsTheme.pink.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          widget.iconData,
          color: widget.color,
          size: widget.size,
        ),
      ),
    );
  }
}
