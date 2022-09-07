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
  late final List<CategoryData> categories;
  double position = 0;
  bool special = false;
  int selectCId = 0;
  late TabController tabController;
  late Calculator calculator;

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
    tabController = TabController(length: 5, vsync: this);
    calculator = Calculator();
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
    List<Widget> specialWidgets = List.empty(growable: true);
    specialWidgets.add(const SizedBox());
    specialWidgets.add(_getRentView(CategoryManager.SPECIAL_RENT_IN));
    specialWidgets.add(_getRentView(CategoryManager.SPECIAL_RENT_OUT));
    specialWidgets.add(_getRentView(CategoryManager.SPECIAL_FINANCE));
    specialWidgets.add(_getRentView(CategoryManager.SPECIAL_TRANSFER));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CategorySelectView(
                color: widget.mainColor,
                categories: categories,
                onSelectCategory: (cid) {
                  setState(() {
                    selectCId = cid;
                    int pageIndex = 0;
                    switch (cid) {
                      case CategoryManager.SPECIAL_RENT_IN:
                        pageIndex = 1;
                        break;
                      case CategoryManager.SPECIAL_RENT_OUT:
                        pageIndex = 2;
                        break;
                      case CategoryManager.SPECIAL_FINANCE:
                        pageIndex = 3;
                        break;
                      case CategoryManager.SPECIAL_TRANSFER:
                        pageIndex = 4;
                        break;
                    }
                    tabController.index = pageIndex;
                    calculator.clear();
                  });
                  //
                },
              )),
        ),
        Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: specialWidgets)),
        const SizedBox(height: 340)
      ],
    );
  }

  Widget _getRentView(int cid) {
    if (cid != CategoryManager.SPECIAL_TRANSFER) {
      var withSelectTime = cid == CategoryManager.SPECIAL_FINANCE;
      return Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: SelectAccountAndInputView(
              calculator: calculator,
              color: widget.mainColor,
              withSelectTime: withSelectTime),
        )
      ]);
    } else {
      return Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: SelectAccountAndInputView(
              calculator: calculator,
              color: widget.mainColor,
              withTransfer: true),
        )
      ]);
    }
  }

  Widget _getNormalInputView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: SelectAccountAndInputView(
              calculator: calculator, color: widget.mainColor),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: CategorySelectView(
                  color: widget.mainColor,
                  categories: categories,
                  onSelectCategory: (cid) {
                    selectCId = cid;
                  },
                ))),
        const SizedBox(height: 340)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                      IconTagListView(mainColor: widget.mainColor,),
                      NumberKeyboardView(
                        mainColor: widget.mainColor,
                        calculator: calculator,
                        onSubmit: (d) {
                          print(d);
                        },
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
