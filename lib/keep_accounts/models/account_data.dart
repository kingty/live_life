import 'package:live_life/keep_accounts/models/bank_data.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';

/// 账户
///
const tableAccountData = 'account_data';
const String cAccountBankDataKey = 'bank_data_key';
const String cAccountName = 'name';
const String cAccountDes = 'des';
const String cAccountCash = 'cash';
const String cAccountFinancial = 'financial';
const String cAccountDebt = 'debt';
const String cAccountLend = 'lend';

String defaultAccountId = 'default_account_id';

class AccountData extends TableData {
  @override
  String getTableName() {
    return tableAccountData;
  }

  AccountData();

  late String bankDataKey; //关联BankData
  late String name; //名字
  late String des; // 描述
  double cash = 0.0; // 流动现金结余
  double financial = 0.0; // 非流动现金结余
  double debt = 0.0; // 负债
  double lend = 0.0; // 借出

  bool isDefaultAccount() {
    //默认账户不计算入资产统计，只记收支账单
    return id == defaultAccountId;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cId: id,
      cAccountBankDataKey: bankDataKey,
      cAccountName: name,
      cAccountDes: des,
      cAccountCash: cash,
      cAccountFinancial: financial,
      cAccountDebt: debt,
      cAccountLend: lend,
    };
    return map;
  }

  @override
  AccountData fromMap(Map<String, dynamic> map) {
    return AccountData()
      ..id = map[cId]
      ..bankDataKey = map[cAccountBankDataKey]
      ..name = map[cAccountName]
      ..des = map[cAccountDes]
      ..cash = map[cAccountCash]
      ..financial = map[cAccountFinancial]
      ..debt = map[cAccountDebt]
      ..lend = map[cAccountLend];
  }

  @override
  AccountData copy() {
    return AccountData().fromMap(toMap());
  }
}
