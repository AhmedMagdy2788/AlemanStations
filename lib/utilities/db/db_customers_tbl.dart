// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:developer';

import 'package:aleman_stations/models/customer.dart';
import 'package:aleman_stations/utilities/db/dbtable_abstract.dart';

import 'db_header.dart';
// import 'package:mysql1/mysql1.dart';

class CustomersDBTbl extends DBTable<Customer> {
//   -- NVARCHAR column is encoded in UTF-16 because a supplementary character enabled collation is used
// CREATE TABLE dbo.MyTable (CharCol NVARCHAR(50) COLLATE utf8_general_ci);

// -- VARCHAR column is encoded the Latin code page and therefore is not Unicode capable
// CREATE TABLE dbo.MyTable (CharCol VARCHAR(50) COLLATE Latin1_General_100_CI_AI);

// ALTER TABLE aleman_db.customers_tbl
// ADD CONSTRAINT UQ_customer_name UNIQUE(cust_name);

// create nonclustered index NIX_FTE_Name
// on Student (Name ASC);
  static const String TBL_NAME = 'customers_tbl';
  final Map<String, String> _ID_COLUMN = {
    DBTable.COL_NAME: 'id',
    DBTable.COL_TYPE: 'INT',
    DBTable.COL_CONSTRAINS: 'UNSIGNED AUTO_INCREMENT PRIMARY KEY'
  };
  final Map<String, String> _CUST_NAME_COLUMN = {
    DBTable.COL_NAME: 'cust_name',
    DBTable.COL_TYPE: 'NVARCHAR(30)',
    DBTable.COL_CONSTRAINS: 'UNIQUE NOT NULL'
  };
  final Map<String, String> _INIT_DEPT_COLUMN = {
    DBTable.COL_NAME: 'init_dept',
    DBTable.COL_TYPE: 'DECIMAL(9,2)',
    DBTable.COL_CONSTRAINS: 'NOT NULL'
  };

  CustomersDBTbl({required String name, required List<DBHeader> headers})
      : super(
          name: TBL_NAME,
          headers: [],
        ) {
    // createTable(connection);
  }

  @override
  String get createTableQuary {
    String idColQuary =
        "${_ID_COLUMN[DBTable.COL_NAME]} ${_ID_COLUMN[DBTable.COL_TYPE]} ${_ID_COLUMN[DBTable.COL_CONSTRAINS]}";
    String custNameQuary =
        "${_CUST_NAME_COLUMN[DBTable.COL_NAME]} ${_CUST_NAME_COLUMN[DBTable.COL_TYPE]} ${_CUST_NAME_COLUMN[DBTable.COL_CONSTRAINS]}";
    String initDeptQuary =
        "${_INIT_DEPT_COLUMN[DBTable.COL_NAME]} ${_INIT_DEPT_COLUMN[DBTable.COL_TYPE]} ${_INIT_DEPT_COLUMN[DBTable.COL_CONSTRAINS]}";
    String sqlQuery =
        "CREATE TABLE IF NOT EXISTS $TBL_NAME ($idColQuary, $custNameQuary, $initDeptQuary)";
    return sqlQuery;
  }

  // @override
  // Future<bool> createTable(MySqlConnection conn) async {
  //   try {
  //     String idColQuary =
  //         "${_ID_COLUMN[DBTable.COL_NAME]} ${_ID_COLUMN[DBTable.COL_TYPE]} ${_ID_COLUMN[DBTable.COL_CONSTRAINS]}";
  //     String custNameQuary =
  //         "${_CUST_NAME_COLUMN[DBTable.COL_NAME]} ${_CUST_NAME_COLUMN[DBTable.COL_TYPE]} ${_CUST_NAME_COLUMN[DBTable.COL_CONSTRAINS]}";
  //     String initDeptQuary =
  //         "${_INIT_DEPT_COLUMN[DBTable.COL_NAME]} ${_INIT_DEPT_COLUMN[DBTable.COL_TYPE]} ${_INIT_DEPT_COLUMN[DBTable.COL_CONSTRAINS]}";
  //     String sqlQuery =
  //         "CREATE TABLE IF NOT EXISTS $TBL_NAME($idColQuary, $custNameQuary, $initDeptQuary)";
  //     await connection.query(sqlQuery, []).then((result) {
  //       log(result.length.toString());
  //       for (var row in result) {
  //         log(row[0]);
  //       }
  //     });
  //     return true;
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }

  @override
  String addRecord(Customer recordObject) {
    String headersName =
        "${_CUST_NAME_COLUMN[DBTable.COL_NAME]}, ${_INIT_DEPT_COLUMN[DBTable.COL_NAME]}";
    String values = "'${recordObject.name}', ${recordObject.initDept}";
    String sqlQuery = "INSERT INTO $TBL_NAME ($headersName) VALUES ($values)";
    return sqlQuery;
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
