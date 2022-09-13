import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/transaction_data.dart';
import 'package:live_life/keep_accounts/ui/record_transaction/select_account_and_input_view.dart';
import '../../control/category_manager.dart';
import '../keep_accounts_them.dart';
import '../../models/category_data.dart';
import 'category_select_view.dart';
import 'icon_tag_list_view.dart';
import 'note_input_view.dart';
import 'number_keyboard_view.dart';

class TransactionInputView extends StatefulWidget {
  const TransactionInputView(
      {super.key,
      required this.mainColor,
      required this.type,
      required this.focusNode,
      this.transactionData});

  @override
  _TransactionInputViewState createState() => _TransactionInputViewState();
  final Color mainColor;
  final int type;
  final FocusNode focusNode;
  final TransactionData? transactionData;
}

class _TransactionInputViewState extends State<TransactionInputView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final List<CategoryData> categories;
  double _position = 0;
  bool _special = false;
  late TabController _tabController;
  late Calculator _calculator;
  late TransactionData _transactionData;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    if (widget.type == 0) {
      categories = CategoryManager.expenseCategories;
    }
    if (widget.type == 1) {
      categories = CategoryManager.incomeCategories;
    }
    if (widget.type == 2) {
      _special = true;
      categories = CategoryManager.specialCategories;
    }
    _tabController = TabController(length: 5, vsync: this);
    _calculator = Calculator();
    WidgetsBinding.instance.addObserver(this);

    _transactionData = widget.transactionData ?? TransactionData();
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          _position = 0.0;
        } else {
          _position = MediaQuery.of(context).viewInsets.bottom > 290.0
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
                    _transactionData.categoryId = cid;
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
                    _tabController.index = pageIndex;
                    _calculator.clear();
                  });
                  //
                },
              )),
        ),
        Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: specialWidgets)),
        const SizedBox(height: 340)
      ],
    );
  }

  Widget _getRentView(int categoryId) {
    return Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: SelectAccountAndInputView(
          calculator: _calculator,
          color: widget.mainColor,
          withSelectTime: categoryId == CategoryManager.SPECIAL_FINANCE,
          withTransfer: categoryId == CategoryManager.SPECIAL_TRANSFER,
          onSelectChanged: (data) {
            //reset
            _transactionData.inAccountId = '';
            _transactionData.outAccountId = '';
            _transactionData.startTime = null;
            _transactionData.endTime = null;
            // use new value
            if (categoryId == CategoryManager.SPECIAL_RENT_IN) {
              _transactionData.inAccountId = data.selectAccountBelow.id;
            }
            if (categoryId == CategoryManager.SPECIAL_RENT_OUT) {
              _transactionData.outAccountId = data.selectAccountBelow.id;
            }
            if (categoryId == CategoryManager.SPECIAL_FINANCE) {
              _transactionData.outAccountId = data.selectAccountBelow.id;
              _transactionData.startTime = data.startTime ?? DateTime.now();
              _transactionData.endTime = data.endTime;
            }
            if (categoryId == CategoryManager.SPECIAL_TRANSFER) {
              _transactionData.inAccountId = data.selectAccountBelow.id;
              _transactionData.outAccountId = data.selectAccount.id;
            }
          },
        ),
      )
    ]);
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
            calculator: _calculator,
            color: widget.mainColor,
            onSelectChanged: (data) {
              if (widget.type == 0) {
                _transactionData.outAccountId = data.selectAccountBelow.id;
              } else if (widget.type == 1) {
                _transactionData.inAccountId = data.selectAccountBelow.id;
              } else {
                throw Exception("should not come here!");
              }
            },
          ),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: CategorySelectView(
                  color: widget.mainColor,
                  categories: categories,
                  onSelectCategory: (cid) {
                    _transactionData.categoryId = cid;
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
            _special ? _getSpecialInputView() : _getNormalInputView(),
            Positioned(
                bottom: _position,
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
                        controller: _noteController,
                      ),
                      IconTagListView(
                        mainColor: widget.mainColor,
                        transactionData: _transactionData,
                      ),
                      NumberKeyboardView(
                        mainColor: widget.mainColor,
                        calculator: _calculator,
                        onSubmit: (d) {
                          _transactionData.amount = d;
                          _transactionData.note = _noteController.value.text;
                          _transactionData.recordTime = DateTime.now();
                          if (kDebugMode) {
                            print(_transactionData.toJson());
                          }
                          var msg = _transactionData.check();
                          if (msg != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: widget.mainColor,
                              content: Text(msg),
                            ));
                          } else {
                            MiddleWare.instance.transaction
                                .saveTransaction(_transactionData)
                                .then((value) => Navigator.pop(context));
                          }
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
