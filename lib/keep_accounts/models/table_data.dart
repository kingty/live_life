const String cId = 'uuid';
const String cIsDelete = 'is_delete';

abstract class TableData {
  TableData();

  String id = '';

  TableData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(); // todo delete

  String getPrimaryKey() {
    return cId;
  }

  String getIsDeleteKey() {
    return cIsDelete;
  }

  String getTableName();

  Map<String, dynamic> toMap();

  TableData fromMap(Map<String, dynamic> map);
}
