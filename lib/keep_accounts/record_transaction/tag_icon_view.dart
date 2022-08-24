import 'package:flutter/material.dart';

import '../keep_accounts_them.dart';

class TagIconView extends StatelessWidget {
  const TagIconView({super.key, required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Ink(
            decoration: const BoxDecoration(
              color: KeepAccountsTheme.background,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: InkWell(
                // highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                      child: Icon(
                        iconData,
                        size: 14,
                        color: KeepAccountsTheme.grey,
                      ),
                    ),
                    TextSpan(
                        text: " $text",
                        style: TextStyle(color: KeepAccountsTheme.grey)),
                  ])),
                ))));
  }
}
