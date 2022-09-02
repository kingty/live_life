/// 账户
class AccountData {
  late int id;
  late String bankDataKey; //关联BankData
  late String name; //名字
  late String des; // 描述
  late double cash; // 流动现金结余
  late double financial; // 非流动现金结余
  late double debt; // 负债
  late double lend; // 借出
}
