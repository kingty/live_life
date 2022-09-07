import 'package:live_life/helper.dart';
import 'package:live_life/keep_accounts/control/category_manager.dart';

class TransactionData {
  TransactionData();

  int id = 0;
  int categoryId = 0; // 账单类型
  // 这里如果转账，记录到同一个账单
  int outAccountId = 0; // 账单产生支出账户
  int inAccountId = 0; // 账单产生收入账户
  double amount = 0.0; // 金额
  String note = ''; // 备注
  int tagId = 0; // 标签
  late DateTime tranTime; // 账单产生时间
  late DateTime recordTime; // 记录时间

  double interest = 0.0; // 理财收益
  DateTime? startTime; // 理财 开始时间
  DateTime? endTime; // 理财 结束时间, 可能为空

  TransactionData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryId = json['categoryId'],
        outAccountId = json['outAccountId'],
        inAccountId = json['inAccountId'],
        amount = json['amount'],
        note = json['note'],
        tagId = json['tagId'],
        recordTime = DateTime.parse(json['recordTime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'outAccountId': outAccountId,
        'inAccountId': inAccountId,
        'amount': amount,
        'note': note,
        'tagId': tagId,
        'tranTime': formatTime(tranTime),
        'recordTime': formatTime(recordTime),
        'interest': interest,
        'startTime': startTime == null ? "" : formatTime(startTime!),
        'endTime': endTime == null ? "" : formatTime(endTime!),
      };

  String? check() {
    if (categoryId == 0) return "请选择类型";
    if (outAccountId == 0 && inAccountId == 0) return "未知错误，账户错误";
    if (amount == 0) return "请输入金额";
    if (isSpecial()) {
      if (categoryId == CategoryManager.SPECIAL_RENT_IN &&
          (inAccountId == 0 || outAccountId != 0)) return "未知错误，账户错误";
      if (categoryId == CategoryManager.SPECIAL_RENT_OUT &&
          (inAccountId != 0 || outAccountId == 0)) return "未知错误，账户错误";
      if (categoryId == CategoryManager.SPECIAL_FINANCE) {
        if (inAccountId != 0 || outAccountId == 0) return "未知错误，账户错误";
        if (startTime == null) return "请选择开始时间";
      }
      if (categoryId == CategoryManager.SPECIAL_TRANSFER &&
          (inAccountId == 0 ||
              outAccountId == 0 ||
              inAccountId == outAccountId)) {
        return "未知错误，账户错误";
      }
    } else if (isIncome()) {
      if (inAccountId == 0 || outAccountId != 0) return "未知错误，账户错误";
    } else if (isExpense()) {
      if (inAccountId != 0 || outAccountId == 0) return "未知错误，账户错误";
    }
    return null;
  }

  int getMonth() {
    return recordTime.month;
  }

  int getDay() {
    return recordTime.day;
  }

  bool isExpense() {
    return categoryId.toString().startsWith("1");
  }

  bool isIncome() {
    return categoryId.toString().startsWith("2");
  }

  bool isSpecial() {
    return categoryId > 3000;
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
