// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:developer';

import 'package:aleman_stations/models/customer.dart';
import 'package:aleman_stations/utilities/db/dbtable_abstract.dart';
import 'package:mysql1/mysql1.dart';

class CustomersDBTbl extends DBTable<Customer> {
  static const String TBL_NAME = 'customers_tbl';
  final Map<String, String> _ID_COLUMN = {
    DBTable.COL_NAME: 'id',
    DBTable.COL_TYPE: 'INT(6)',
    DBTable.COL_CONSTRAINS: 'UNSIGNED AUTO_INCREMENT PRIMARY KEY'
  };
  final Map<String, String> _CUST_NAME_COLUMN = {
    DBTable.COL_NAME: 'cust_name',
    DBTable.COL_TYPE: 'VARCHAR(30)',
    DBTable.COL_CONSTRAINS: 'NOT NULL'
  };
  final Map<String, String> _INIT_DEPT_COLUMN = {
    DBTable.COL_NAME: 'init_dept',
    DBTable.COL_TYPE: 'FLOAT(9)',
    DBTable.COL_CONSTRAINS: 'NOT NULL'
  };

  MySqlConnection connection;

  CustomersDBTbl(this.connection)
      : super(
          name: TBL_NAME,
          headers: [],
        ) {
    createTable(connection);
  }

  @override
  Future<bool> createTable(MySqlConnection conn) async {
    try {
      String idColQuary =
          "${_ID_COLUMN[DBTable.COL_NAME]} ${_ID_COLUMN[DBTable.COL_TYPE]} ${_ID_COLUMN[DBTable.COL_CONSTRAINS]}";
      String custNameQuary =
          "${_CUST_NAME_COLUMN[DBTable.COL_NAME]} ${_CUST_NAME_COLUMN[DBTable.COL_TYPE]} ${_CUST_NAME_COLUMN[DBTable.COL_CONSTRAINS]}";
      String initDeptQuary =
          "${_INIT_DEPT_COLUMN[DBTable.COL_NAME]} ${_INIT_DEPT_COLUMN[DBTable.COL_TYPE]} ${_INIT_DEPT_COLUMN[DBTable.COL_CONSTRAINS]}";
      String sqlQuery =
          "CREATE TABLE IF NOT EXISTS $TBL_NAME($idColQuary, $custNameQuary, $initDeptQuary)";

      await connection.query(sqlQuery, []).then((result) {
        log(result.length.toString());
        for (var row in result) {
          log(row[0]);
        }
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> addRecord(Customer recordObject) {
    // TODO: implement addRecord
    throw UnimplementedError();
  }

  @override
  Future<List<Customer>> getAllRecords() {
    // TODO: implement getAllRecords
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteRecord(Customer recordObject) {
    // TODO: implement deleteRecord
    throw UnimplementedError();
  }

  @override
  Future<bool> updateRecord(Customer recordObject) {
    // TODO: implement updateRecord
    throw UnimplementedError();
  }
}
