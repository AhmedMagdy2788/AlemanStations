import '../db/db_header.dart';

abstract class StorageResource {
  bool createTable(String tblName, List<DBHeader> headers);
}
