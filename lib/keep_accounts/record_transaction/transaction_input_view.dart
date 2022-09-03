import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/record_transaction/select_account_and_input_view.dart';
import '../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../models/category_data.dart';
import 'category_select_view.dart';
import 'icon_tag_list_view.dart';
import 'note_input_view.dart';
import 'number_keyboard_view.dart';

class TransactionInputView extends StatefulWidget {
  const TransactionInputView(
      {super.key,
      required this.mainColor,
      required this.type,
      required this.focusNode});

  @override
  _TransactionInputViewState createState() => _TransactionInputViewState();
  final Color mainColor;
  final int type;
  final FocusNode focusNode;
}

class _TransactionInputViewState extends State<TransactionInputView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Future<bool> getData() async {
    return CategoryManager.instance.fetchCategories();
  }

  late final List<CategoryData> categories;
  double position = 0;
  bool special = false;

  @override
  void initState() {
    if (widget.type == 0) {
      categories = CategoryManager.expenseCategories;
    }
    if (widget.type == 1) {
      categories = CategoryManager.incomeCategories;
    }
    if (widget.type == 2) {
      special = true;
      categories = CategoryManager.specialCategories;
    }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          position = 0.0;
        } else {
          position = MediaQuery.of(context).viewInsets.bottom > 290.0
              ? MediaQuery.of(context).viewInsets.bottom - 290.0
              : 0.0;
        }
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget _getSpecialInputView() {
    return Text("data");
  }

  Widget _getNormalInputView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: SelectAccountAndInputView(color: widget.mainColor),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return CategorySelectView(
                  color: widget.mainColor,
                  categories: categories,
                  onSelectCategory: (cid) {
                    //
                  },
                );
              }
            },
          ),
        )),
        const SizedBox(height: 340)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        widget.focusNode.unfocus();
      },
      child: Container(
        color: KeepAccountsTheme.background,
        child: Stack(
          children: [
            special ? _getSpecialInputView() : _getNormalInputView(),
            Positioned(
                bottom: position,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 340,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NoteInputView(
                        focusNode: widget.focusNode,
                        color: widget.mainColor,
                      ),
                      IconTagListView(),
                      NumberKeyboardView(mainColor: widget.mainColor)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
