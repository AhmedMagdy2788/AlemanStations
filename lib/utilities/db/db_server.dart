import 'dart:developer';

import 'package:aleman_stations/utilities/db/dbtable_abstract.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

import '../../models/customer.dart';
import 'db_header.dart';

class DBServer {
  final String host, user, password, dbName;
  final int port;
  final List<DBTable> _tables = [];
  DBServer({
    required this.host,
    required this.port,
    required this.dbName,
    required this.user,
    required this.password,
  });

  List<DBTable> get tables => [..._tables];

  Future<bool> addTable(String tblName, List<DBHeader> headers) async {
    try {
      for (var tbl in _tables) {
        if (tbl.name == tblName) {
          log('table $tblName already created!!');
          return false;
        }
      }
      DBTable<Customer> custTbl = DBTable<Customer>(
        name: tblName,
        headers: headers,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> initDB() async {
    try {
      await MySqlConnection.connect(ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
      )).then((conn) {
        conn.query("CREATE DATABASE IF NOT EXISTS $dbName", []).then((result) {
          log('the rows length = ${result.length}');
          for (var row in result) {
            log(row[0]);
          }
        });
        conn.close();
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<MySqlConnection> getConnection() {
    final conn = MySqlConnection.connect(ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: dbName,
      password: password,
    ));
    return conn;
  }
}

//////////////////////////php impelmentation using xammp server//////////////////
  // static const String ROOT = "http://localshost/Aleman_db/Aleman_actions.php";
  // static const String CREATE_TABLE_ACTION = "CREATE_TABLE";
  // static const String _GET_ALL_ACTION = "GET_ALL";
  // static const String _ADD_CUST_ACTION = "ADD_CSUT";
  // static const String _UPDATE_CUST_ACTION = "UPDATE_CUST";
  // static const String _DELETE_CUST_ACTION = "DELETE_CUST";

  // //Method to create the table customers
  // static Future<String> createTable() async {
  //   try {
  //     var map = <String, dynamic>{};
  //     map['action'] = CREATE_TABLE_ACTION;
  //     final response = await http.post(Uri.parse(ROOT), body: map);
  //     log("Create Table Response: ${response.body}");
  //     return response.body;
  //   } catch (e) {
  //     return "error";
  //   }
  // }