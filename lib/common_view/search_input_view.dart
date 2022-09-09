import 'package:flutter/material.dart';

import '../app_theme.dart';

class SearchInputView extends StatefulWidget {
  const SearchInputView({Key? key, this.onSearchTextChanged}) : super(key: key);

  final ValueChanged<String>? onSearchTextChanged;

  @override
  // ignore: library_private_types_in_public_api
  _SearchInputViewState createState() => _SearchInputViewState();
}

class _SearchInputViewState extends State<SearchInputView>
    with TickerProviderStateMixin {
  bool showClearIcon = false;
  var mainColor = AppTheme.nearlyDarkBlue;
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.01),
                offset: const Offset(0.0, 5.0),
                blurRadius: 5.0),
          ],
        ),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.search, color: mainColor)),
            Expanded(
                child: TextField(
              controller: pass,
              onChanged: (text) {
                setState(() {
                  showClearIcon = text.isNotEmpty;
                  widget.onSearchTextChanged?.call(text);
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: mainColor,
                    letterSpacing: 0,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: "搜索..."),
              textAlign: TextAlign.left,
              cursorColor: mainColor,
              cursorWidth: 2,
              style: TextStyle(
                color: mainColor,
                letterSpacing: 0,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )),
            Visibility(
                visible: showClearIcon,
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Material(
                        color: Colors.transparent,
                        child: Ink(
                            decoration: const BoxDecoration(
                              color: AppTheme.background,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: InkWell(
                                // highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                onTap: () {
                                  setState(() {
                                    pass.clear();
                                    showClearIcon = false;
                                    widget.onSearchTextChanged?.call("");
                                  });
                                },
                                child: Icon(
                                  Icons.highlight_remove_outlined,
                                  color: mainColor,
                                )))))),
            const SizedBox(width: 5)
          ],
        ));
  }
}
