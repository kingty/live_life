import 'package:flutter/material.dart';

import '../keep_accounts/keep_accounts_them.dart';

class SearchInputView extends StatefulWidget {
  const SearchInputView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchInputViewState createState() => _SearchInputViewState();
}

class _SearchInputViewState extends State<SearchInputView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: KeepAccountsTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: KeepAccountsTheme.grey.withOpacity(0.01),
                offset: const Offset(0.0, 5.0),
                blurRadius: 5.0),
          ],
        ),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.search,
                    color: KeepAccountsTheme.nearlyDarkBlue)),
            const Expanded(
                child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: KeepAccountsTheme.nearlyDarkBlue,
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: "搜索..."),
              textAlign: TextAlign.left,
              cursorColor: KeepAccountsTheme.nearlyDarkBlue,
              cursorWidth: 2,
              style: TextStyle(
                color: KeepAccountsTheme.nearlyDarkBlue,
                letterSpacing: 0,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )),
            SizedBox(
                width: 40,
                height: 40,
                child: Material(
                    color: Colors.transparent,
                    child: Ink(
                        decoration: const BoxDecoration(
                          color: KeepAccountsTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: InkWell(
                            // highlightColor: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            onTap: () {},
                            child: const Icon(
                              Icons.highlight_remove_outlined,
                              color: KeepAccountsTheme.nearlyDarkBlue,
                            ))))),
            const SizedBox(width: 5)
          ],
        ));
  }
}
