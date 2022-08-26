class TransactionData {
  late int id;
  late int categoryId; // 账单类型
  // 这里如果转账，记录到同一个账单
  late int outAccountId; // 账单产生支出账户
  late int inAccountId; // 账单产生收入账户
  late double amount; // 金额
  late String note; // 备注
  late int tagId; // 标签
  late DateTime recordTime; // 记录时间

  TransactionData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryId = json['categoryId'],
        outAccountId = json['outAccountId'],
        inAccountId = json['inAccountId'],
        amount = json['amount'],
        note = json['note'],
        tagId = json['tagId'],
        recordTime = DateTime.parse(json['recordTime']);

  int getMonth() {
    return recordTime.month;
  }

  int getDay() {
    return recordTime.day;
  }

  bool isExpense() {
    return categoryId.toString().startsWith("1");
  }
}

class DayOverViewData {
  final DateTime firstTransactionDate;
  double countIncome = 0;
  double countExpense = 0;

  DayOverViewData(this.firstTransactionDate);

  static List<String> weeks = ["一", "二", "三", "四", "五", "六", "日"];

  String getDisplayDateString() {
    return "星期${weeks.elementAt(firstTransactionDate.weekday - 1)} ${firstTransactionDate.month}月${firstTransactionDate.day}日";
  }
}
