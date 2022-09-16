import 'package:live_life/helper.dart';
import 'package:live_life/keep_accounts/control/category_manager.dart';
import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/models/table_data.dart';

const tableTransactionData = 'transaction_data';
const indexTransactionTime = 'transaction_time_index';

const String cTransactionCategoryId = 'category_id';
const String cTransactionOutAccountId = 'out_account_id';
const String cTransactionInAccountId = 'in_account_id';
const String cTransactionAmount = 'amount';
const String cTransactionNote = 'note';
const String cTransactionTagId = 'tag_id';
const String cTransactionTranTime = 'tran_time';
const String cTransactionRecordTime = 'record_time';
const String cTransactionInterest = 'interest';
const String cTransactionStartTime = 'start_time';
const String cTransactionEndTime = 'end_time';
const String cTransactionIsEnd = 'is_end';

class TransactionData extends TableData {
  @override
  String getTableName() {
    return tableTransactionData;
  }

  TransactionData();

  int categoryId = 0; // 账单类型
  // 这里如果转账，记录到同一个账单
  String outAccountId = ''; // 账单产生支出账户
  String inAccountId = ''; // 账单产生收入账户
  double amount = 0.0; // 金额
  String note = ''; // 备注
  String tagId = ''; // 标签
  late DateTime tranTime; // 账单产生时间
  late DateTime recordTime; // 记录时间

  double interest = 0.0; // 理财收益,
  DateTime? startTime; // 理财 开始时间
  DateTime? endTime; // 理财 结束时间, 可能为空
  int isEnd = 0; //特殊类型是否结束

  TransactionData.fromJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'],
        outAccountId = json['outAccountId'].toString(),
        inAccountId = json['inAccountId'].toString(),
        amount = json['amount'],
        note = json['note'],
        tagId = json['tagId'].toString(),
        recordTime = DateTime.parse(json['recordTime']),
        super.fromJson(json);

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
    if (id.isEmpty) return "未知错误，id错误";
    if (categoryId == 0) return "请选择类型";
    if (outAccountId.isEmpty && inAccountId.isEmpty) return "未知错误，账户错误";
    if (amount == 0) return "请输入金额";
    if (isSpecial()) {
      if (inAccountId == MiddleWare.instance.account.defaultAccount.id ||
          outAccountId == MiddleWare.instance.account.defaultAccount.id) {
        return "此类型不能选择默认账户";
      }
      if (categoryId == CategoryManager.SPECIAL_RENT_IN &&
          (inAccountId.isEmpty || outAccountId.isNotEmpty)) return "未知错误，账户错误";
      if (categoryId == CategoryManager.SPECIAL_RENT_OUT &&
          (inAccountId.isNotEmpty || outAccountId.isEmpty)) return "未知错误，账户错误";
      if (categoryId == CategoryManager.SPECIAL_FINANCE) {
        if (inAccountId.isNotEmpty || outAccountId.isEmpty) return "未知错误，账户错误";
        if (startTime == null) return "请选择开始时间";
      }
      if (categoryId == CategoryManager.SPECIAL_TRANSFER &&
          (inAccountId.isEmpty ||
              outAccountId.isEmpty ||
              inAccountId == outAccountId)) {
        return "未知错误，账户错误";
      }
    } else if (isIncome()) {
      if (inAccountId.isEmpty || outAccountId.isNotEmpty) return "未知错误，账户错误";
    } else if (isExpense()) {
      if (inAccountId.isNotEmpty || outAccountId.isEmpty) return "未知错误，账户错误";
    }
    return null;
  }

  int getMonth() {
    return tranTime.month;
  }

  int getDay() {
    return tranTime.day;
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

  bool isCurrentWeek() {
    var d = DateTime.now();
    var weekDay = d.weekday;
    var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
    firstDayOfWeek =
        DateTime(firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
    return tranTime.millisecondsSinceEpoch >=
        firstDayOfWeek.millisecondsSinceEpoch;
  }

  int getRootCategoryId() {
    if (categoryId < 10000) {
      return categoryId;
    } else {
      return categoryId ~/ 1000;
    }
  }

  /// return null only with SPECIAL_TRANSFER type
  String? getRealAccountId() {
    if (isIncome()) {
      return inAccountId;
    } else if (isExpense()) {
      return outAccountId;
    } else {
      if (categoryId == CategoryManager.SPECIAL_RENT_IN) return inAccountId;
      if (categoryId == CategoryManager.SPECIAL_RENT_OUT) return outAccountId;
      if (categoryId == CategoryManager.SPECIAL_FINANCE) return outAccountId;
      if (categoryId == CategoryManager.SPECIAL_TRANSFER) return null;
    }

    return null;
  }

  @override
  TransactionData fromMap(Map<String, dynamic> map) {
    return TransactionData()
      ..id = map[cId]
      ..categoryId = map[cTransactionCategoryId]
      ..outAccountId = map[cTransactionOutAccountId]
      ..inAccountId = map[cTransactionInAccountId]
      ..amount = map[cTransactionAmount]
      ..note = map[cTransactionNote]
      ..tagId = map[cTransactionTagId]
      ..tranTime =
          DateTime.fromMillisecondsSinceEpoch(map[cTransactionTranTime])
      ..recordTime =
          DateTime.fromMillisecondsSinceEpoch(map[cTransactionRecordTime])
      ..interest = map[cTransactionInterest]
      ..startTime = map[cTransactionStartTime] == 0
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map[cTransactionStartTime])
      ..endTime = map[cTransactionEndTime] == 0
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map[cTransactionEndTime])
      ..isEnd = map[cTransactionIsEnd]?? 0;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cId: id,
      cTransactionCategoryId: categoryId,
      cTransactionOutAccountId: outAccountId,
      cTransactionInAccountId: inAccountId,
      cTransactionAmount: amount,
      cTransactionNote: note,
      cTransactionTagId: tagId,
      cTransactionTranTime: tranTime.millisecondsSinceEpoch,
      cTransactionRecordTime: recordTime.millisecondsSinceEpoch,
      cTransactionInterest: interest,
      cTransactionStartTime:
          startTime != null ? startTime?.millisecondsSinceEpoch : 0,
      cTransactionEndTime:
          endTime != null ? endTime?.millisecondsSinceEpoch : 0,
      cTransactionIsEnd: isEnd
    };
    return map;
  }
}
