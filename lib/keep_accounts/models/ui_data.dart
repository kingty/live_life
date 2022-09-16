import 'package:live_life/keep_accounts/models/transaction_data.dart';

import '../../helper.dart';
import '../control/category_manager.dart';
import 'category_data.dart';

class MonthOverviewData {
  late int month;
  double countIncome = 0;
  double countExpense = 0;
}

class DayOverViewData {
  final DateTime firstTransactionDate;
  double countIncome = 0;
  double countExpense = 0;
  List<TransactionData>? transactionsExpense;
  List<TransactionData>? transactionsIncome;
  List<TransactionData>? transactionsSpecial;

  DayOverViewData(this.firstTransactionDate);

  static List<String> weeks = ["一", "二", "三", "四", "五", "六", "日"];

  String getDisplayDateString() {
    return "星期${weeks.elementAt(firstTransactionDate.weekday - 1)} ${firstTransactionDate.month}月${firstTransactionDate.day}日";
  }

  //获取同一个月的每天汇总数据，必须保证是一个月数据
  static List<DayOverViewData> getDayOverViewDatas(
      DateTime firstDayOfMonth, List<TransactionData> transactions) {
    // 本月有多少天
    var dayCount =
        DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day;

    Map<int, DayOverViewData> kvs = {};
    for (int index = 1; index <= dayCount; index++) {
      kvs[index] = DayOverViewData(
          DateTime(firstDayOfMonth.year, firstDayOfMonth.month, index))
        ..transactionsExpense = List.empty(growable: true)
        ..transactionsIncome = List.empty(growable: true)
        ..transactionsSpecial = List.empty(growable: true);
    }

    transactions.sort((a, b) {
      return b.tranTime.compareTo(a.tranTime);
    });
    for (var transaction in transactions) {
      DayOverViewData current = kvs[transaction.getDay()]!;
      if (transaction.isExpense()) {
        // 消费
        current.countExpense = current.countExpense + transaction.amount;
        current.transactionsExpense!.add(transaction);
      } else if (transaction.isIncome()) {
        current.countIncome = current.countIncome + transaction.amount;
        current.transactionsIncome!.add(transaction);
      } else {
        current.transactionsSpecial!.add(transaction);
      }
    }
    List<DayOverViewData> result = kvs.values.toList();
    result.sort((a, b) {
      return a.firstTransactionDate.compareTo(b.firstTransactionDate);
    });
    return result;
  }
}

class CircleChartData {
  late CategoryData categoryData;
  late List<TransactionData> transactions;
  late double amount;

  static List<CircleChartData> dealFromSources(
      List<TransactionData> transactions) {
    final List<CircleChartData> chartData = List.empty(growable: true);
    if (transactions.isEmpty) return chartData;
    Map<int, Pair<List<TransactionData>, double>> map = {};
    for (var element in transactions) {
      if (!map.containsKey(element.getRootCategoryId())) {
        map[element.getRootCategoryId()] = Pair(List.empty(growable: true), 0);
      }
      map[element.getRootCategoryId()]!.first.add(element);
      map[element.getRootCategoryId()]!.second =
          map[element.getRootCategoryId()]!.second + element.amount;
    }
    return map.keys
        .map((key) => CircleChartData()
          ..categoryData = CategoryManager.instance.getById(key)!
          ..transactions = map[key]!.first
          ..amount = map[key]!.second)
        .toList();
  }
}

class StatisticsViewData {
  StatisticsViewData.empty()
      : transactions = List.empty(),
        expenses = List.empty(),
        incomes = List.empty(),
        special = List.empty(),
        sumExpense = 0,
        sumIncome = 0,
        sumBalance = 0;

  StatisticsViewData(List<TransactionData> source) {
    transactions = source;
    List<CircleChartData> all = CircleChartData.dealFromSources(source);
    expenses =
        all.where((element) => element.categoryData.isExpense()).toList();
    incomes = all.where((element) => element.categoryData.isIncome()).toList();
    special = all.where((element) => element.categoryData.isSpecial()).toList();

    sumExpense = expenses
        .map((e) => e.amount)
        .reduce((value, element) => value = value + element);
    sumIncome = incomes
        .map((e) => e.amount)
        .reduce((value, element) => value = value + element);
    sumBalance = sumIncome - sumExpense;
  }

  late List<CircleChartData> expenses;
  late List<TransactionData> transactions;
  late List<CircleChartData> incomes;
  late List<CircleChartData> special;
  late double sumExpense;
  late double sumIncome;
  late double sumBalance;
}
