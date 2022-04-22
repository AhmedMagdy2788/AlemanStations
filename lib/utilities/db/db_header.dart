//TODO:we need to impliment the decorated pattern for the DBHeader
class DBHeader {
  String name;
  String type;
  bool _isPrimaryKey = false;
  bool _isForgenKey = false;
  bool isNullable = false;
  bool isUnique = false;
  DBHeader({required this.name, required this.type});

  bool get isPrimaryKey => _isPrimaryKey;

  set isPrimaryKey(bool isPrimaryKey) {
    _isPrimaryKey = isPrimaryKey;
    _isForgenKey = false;
  }

  bool get isForgenKey => _isForgenKey;

  set isForgenKey(bool _isForgenKey) {
    _isForgenKey = isForgenKey;
    _isPrimaryKey = false;
  }
}
