import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common_view/dot_line_border.dart';
import '../keep_accounts_them.dart';

class AssetManagementOverviewView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const AssetManagementOverviewView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  _AssetManagementOverviewViewState createState() =>
      _AssetManagementOverviewViewState();
}

class _AssetManagementOverviewViewState
    extends State<AssetManagementOverviewView> with TickerProviderStateMixin {
  var borderColor = Colors.black12.withOpacity(0.03);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: _getMainUi()));
        });
  }

  Widget _getMainUi() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: KeepAccountsTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: KeepAccountsTheme.grey.withOpacity(0.01),
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 5.0),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Text("净资产")),
              const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "¥ 201110.34",
                    style: TextStyle(fontSize: 30),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: borderColor, width: 1),
                        bottom: BorderSide(color: borderColor, width: 1)),
                  ),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: borderColor, width: 1))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "现金",
                                  style: KeepAccountsTheme.caption,
                                ),
                                Text(
                                  "¥ 109990.34",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ))),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                          Text("理财", style: KeepAccountsTheme.caption),
                          Text(
                            "¥ 123445.22",
                            style: TextStyle(
                                fontSize: 20,
                                color: KeepAccountsTheme.nearlyDarkBlue,
                                fontWeight: FontWeight.w500),
                          ),
                        ]))
                  ])),
              Row(children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: borderColor, width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text("负债", style: KeepAccountsTheme.caption),
                            Text(
                              "¥ 123445",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: KeepAccountsTheme.darkRed,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                      Text("借出", style: KeepAccountsTheme.caption),
                      Text(
                        "¥ 123445",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                    ]))
              ])
            ],
          ),
        ));
  }
}
