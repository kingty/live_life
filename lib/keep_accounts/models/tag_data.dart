// 标签，对账单更灵活的分类
import 'package:live_life/keep_accounts/models/table_data.dart';

const tableTagData = 'tag_data';

const String cTagName = 'name';
const String cTagDes = 'des';

class TagData extends TableData {
  late String name; // tag 名称
  late String des;

  @override
  String getTableName() {
    return tableTagData;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cId: id,
      cTagName: name,
      cTagDes: des,
    };
    return map;
  }

  @override
  TagData fromMap(Map<String, dynamic> map) {
    return TagData()
      ..id = map[cId]
      ..name = map[cTagName]
      ..des = map[cTagDes];
  }

  @override
  TagData copy() {
    return TagData().fromMap(toMap());
  }
}
