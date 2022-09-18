import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_life/helper.dart';
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
      this.editTransactionData});

  @override
  _TransactionInputViewState createState() => _TransactionInputViewState();
  final Color mainColor;
  final int type;
  final FocusNode focusNode;
  final TransactionData? editTransactionData;
}

class _TransactionInputViewState extends State<TransactionInputView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final List<CategoryData> categories;
  double _position = 0;
  bool _special = false;
  late TabController _tabController;
  late Calculator _calculator;
  late TransactionData _saveTransactionData;
  late TransactionData? _editTransactionData;
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

    _saveTransactionData = widget.editTransactionData == null
        ? TransactionData()
        : widget.editTransactionData!.copy();
    _editTransactionData = widget.editTransactionData;

    if (widget.editTransactionData != null) {
      Future.delayed(Duration.zero).then((_) async {
        _noteController.text = widget.editTransactionData!.note;
        _calculator.setValue(widget.editTransactionData!.amount);
      });
    }
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
    _editTransactionData = null;
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget _getSpecialInputView() {
    if (widget.editTransactionData != null) {
      switch (widget.editTransactionData!.categoryId) {
        case CategoryManager.SPECIAL_RENT_IN:
          _tabController.index = 1;
          break;
        case CategoryManager.SPECIAL_RENT_OUT:
          _tabController.index = 2;
          break;
        case CategoryManager.SPECIAL_FINANCE:
          _tabController.index = 3;
          break;
        case CategoryManager.SPECIAL_TRANSFER:
          _tabController.index = 4;
          break;
      }
    }
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
                editTransactionData: _editTransactionData,
                color: widget.mainColor,
                categories: categories,
                onSelectCategory: (cid) {
                  setState(() {
                    _saveTransactionData.categoryId = cid;
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
          editTransactionData: _editTransactionData,
          calculator: _calculator,
          color: widget.mainColor,
          withSelectTime: categoryId == CategoryManager.SPECIAL_FINANCE,
          withTransfer: categoryId == CategoryManager.SPECIAL_TRANSFER,
          onSelectChanged: (data) {
            //reset
            _saveTransactionData.inAccountId = '';
            _saveTransactionData.outAccountId = '';
            _saveTransactionData.startTime = null;
            _saveTransactionData.endTime = null;
            // use new value
            if (categoryId == CategoryManager.SPECIAL_RENT_IN) {
              _saveTransactionData.inAccountId = data.selectAccountBelow.id;
            }
            if (categoryId == CategoryManager.SPECIAL_RENT_OUT) {
              _saveTransactionData.outAccountId = data.selectAccountBelow.id;
            }
            if (categoryId == CategoryManager.SPECIAL_FINANCE) {
              _saveTransactionData.outAccountId = data.selectAccountBelow.id;
              _saveTransactionData.startTime = data.startTime ?? DateTime.now();
              _saveTransactionData.endTime = data.endTime;
            }
            if (categoryId == CategoryManager.SPECIAL_TRANSFER) {
              _saveTransactionData.inAccountId = data.selectAccountBelow.id;
              _saveTransactionData.outAccountId = data.selectAccount.id;
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
            editTransactionData: _editTransactionData,
            calculator: _calculator,
            color: widget.mainColor,
            onSelectChanged: (data) {
              if (widget.type == 0) {
                _saveTransactionData.outAccountId = data.selectAccountBelow.id;
              } else if (widget.type == 1) {
                _saveTransactionData.inAccountId = data.selectAccountBelow.id;
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
                  editTransactionData: _editTransactionData,
                  color: widget.mainColor,
                  categories: categories,
                  onSelectCategory: (cid) {
                    _saveTransactionData.categoryId = cid;
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
                        savetransactionData: _saveTransactionData,
                        editTransactionData: _editTransactionData,
                      ),
                      NumberKeyboardView(
                        mainColor: widget.mainColor,
                        calculator: _calculator,
                        onSubmit: (d) {
                          _saveTransactionData.amount = d;
                          _saveTransactionData.note =
                              _noteController.value.text;
                          _saveTransactionData.recordTime = DateTime.now();
                          if (kDebugMode) {
                            print(_saveTransactionData.toJson());
                          }
                          var msg = _saveTransactionData.check();
                          if (msg != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: widget.mainColor,
                              content: Text(msg),
                            ));
                          } else {
                            if (_saveTransactionData.id.isEmpty) {
                              _saveTransactionData.id = uuid.v1();//新账单
                            }
                            MiddleWare.instance.transaction
                                .saveTransaction(_saveTransactionData)
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
