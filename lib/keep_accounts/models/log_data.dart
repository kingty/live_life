
const tableLogData = 'account_data';
const String cSql='sql';
const String cArgs='args';

class LogData{
  LogData();
  late String sql;
  late String args;


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cSql: sql,
      cArgs: args
    };
    return map;
  }

  LogData.fromMap(Map<String, dynamic> map) {
    sql = map[cSql];
    args = map[cArgs];
  }
}