import 'package:flutter/material.dart';

import '../keep_accounts_them.dart';

class NoteInputView extends StatelessWidget {
  const NoteInputView({super.key, required this.color, this.controller, required this.focusNode});

  final TextEditingController? controller;
  final Color color;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
        // constraints: BoxConstraints(maxHeight: 40),
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        color: KeepAccountsTheme.grey.withOpacity(0.1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: TextField(
            // keyboardType: TextInputType.multiline,
            // maxLines: 2,
            // minLines: 1,
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: KeepAccountsTheme.background,
                prefixIconColor: color,
                // contentPadding: EdgeInsets.only(left: 24, top: 4, bottom: 4, right: 24),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.note_add),
                hintText: "请输入备注信息"),
            cursorColor: color,
          ),
        ));
  }
}
