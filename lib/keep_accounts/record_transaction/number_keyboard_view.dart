import 'package:flutter/material.dart';

import '../keep_accounts_them.dart';

class NumberKeyboardView extends StatelessWidget {
  const NumberKeyboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: KeepAccountsTheme.grey.withOpacity(0.1),
        height: 250,
        child: Column(
          children: [
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                SizedBox(width: 2),
                NumberView(
                  sign: "1",
                ),
                SizedBox(width: 4),
                NumberView(
                  sign: "2",
                ),
                SizedBox(width: 4),
                NumberView(
                  sign: "3",
                ),
                SizedBox(width: 4),
                DeleteView(),
                SizedBox(width: 2),
              ],
            ),
            const SizedBox(height: 4),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  SizedBox(width: 2),
                  NumberView(
                    sign: "4",
                  ),
                  SizedBox(width: 4),
                  NumberView(
                    sign: "5",
                  ),
                  SizedBox(width: 4),
                  NumberView(
                    sign: "6",
                  ),
                  SizedBox(width: 4),
                  NumberView(
                    sign: "+",
                  ),
                  SizedBox(width: 2),
                ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Expanded(
                flex: 3,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        SizedBox(width: 2),
                        NumberView(
                          sign: "7",
                        ),
                        SizedBox(width: 4),
                        NumberView(
                          sign: "8",
                        ),
                        SizedBox(width: 4),
                        NumberView(
                          sign: "9",
                        )
                      ]),
                  const SizedBox(height: 4),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        SizedBox(width: 2),
                        NumberView(
                          sign: "-",
                        ),
                        SizedBox(width: 4),
                        NumberView(
                          sign: "0",
                        ),
                        SizedBox(width: 4),
                        NumberView(
                          sign: ".",
                        )
                      ]),
                ]),
              ),
              const SizedBox(width: 3),
              Expanded(
                  child: Row(
                children: const [
                  SizedBox(width: 1),
                  NumberView(
                    height: 108,
                    sign: "保存",
                  ),
                  SizedBox(width: 2),
                ],
              )),
            ])
          ],
        ));
  }
}

class NumberView extends StatelessWidget {
  final String sign;
  final double height;
  final Color color;

  const NumberView(
      {super.key,
      required this.sign,
      this.height = 50,
      this.color = KeepAccountsTheme.grey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Material(
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
                    child: Container(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 4),
                        height: height,
                        alignment: Alignment.center,
                        child: Text(
                          sign,
                          style: TextStyle(
                            fontSize: 20,
                            height: 0.9,
                            color: color,
                          ),
                        ))))));
  }
}

class DeleteView extends StatelessWidget {
  const DeleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Material(
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
                    child: Container(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 4),
                        height: 50,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.backspace_sharp,
                          color: KeepAccountsTheme.grey,
                        ))))));
  }
}
