import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:flutter/material.dart';
import '../keep_accounts_them.dart';

class AccountsListView extends StatefulWidget {
  const AccountsListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _AccountsListViewState createState() => _AccountsListViewState();
}

class _AccountsListViewState extends State<AccountsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<BankData> banks = BankData.gydxsyyh.values.toList();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, right: 16, left: 16),
                itemCount: banks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = banks.length > 4 ? 4 : banks.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval(
                                  (1 / count) * (index > 4 ? 4 : index), 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return AccountView(
                    bankData: banks[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class AccountView extends StatelessWidget {
  const AccountView(
      {Key? key,
      required this.bankData,
      this.animationController,
      this.animation})
      : super(key: key);

  final BankData bankData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: bankData.mainColor.withOpacity(0.5),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <Color>[
                            bankData.mainColor.withOpacity(0.2),
                            bankData.mainColor.withOpacity(0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              bankData.simpleName(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: KeepAccountsTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.2,
                                color: KeepAccountsTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      //Todo change it
                                      ['滕金廷', '储蓄卡', '我的备注'].join("\n"),
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontFamily: KeepAccountsTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.2,
                                        color: KeepAccountsTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            bankData.temp != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 4, bottom: 0),
                                        child: Text(
                                          '¥',
                                          style: TextStyle(
                                            fontFamily:
                                                KeepAccountsTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            letterSpacing: 0.2,
                                            color: KeepAccountsTheme.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        bankData.temp.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily:
                                              KeepAccountsTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          letterSpacing: 0.2,
                                          color: KeepAccountsTheme.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: KeepAccountsTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: KeepAccountsTheme.nearlyBlack
                                                .withOpacity(0.4),
                                            offset: const Offset(8.0, 8.0),
                                            blurRadius: 8.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: bankData.mainColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -24,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: KeepAccountsTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 20,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(bankData.logo),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
