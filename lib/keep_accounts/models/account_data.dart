/// 账户
///
const tableAccountData = 'account_data';
const String cId = 'uuid';
const String cBankDataKey = 'bank_data_key';
const String cName = 'name';
const String cDes = 'des';
const String cCash = 'cash';
const String cFinancial = 'financial';
const String cDebt = 'debt';
const String cLend = 'lend';

class AccountData {
  AccountData();

  late String id;
  late String bankDataKey; //关联BankData
  late String name; //名字
  late String des; // 描述
  late double cash; // 流动现金结余
  late double financial; // 非流动现金结余
  late double debt; // 负债
  late double lend; // 借出

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cId: id,
      cBankDataKey: bankDataKey,
      cName: name,
      cDes: des,
      cCash: cash,
      cFinancial: financial,
      cDebt: debt,
      cLend: lend,
    };
    return map;
  }

  AccountData.fromMap(Map<String, dynamic> map) {
    id = map[cId];
    bankDataKey = map[cBankDataKey];
    name = map[cName];
    des = map[cDes];
    cash = map[cCash];
    financial = map[cFinancial];
    debt = map[cDebt];
    lend = map[cLend];
  }
}
