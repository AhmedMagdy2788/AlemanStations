import 'dart:developer';

import 'package:aleman_stations/utilities/db/dbtable_abstract.dart';
import 'package:aleman_stations/utilities/storage_API/storage_event.dart';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

import '../storage_API/table.dart';
import 'db_customers_tbl.dart';
import 'db_header.dart';

class DBServer with ChangeNotifier {
// ALTER TABLE customers_tbl MODIFY cust_name VARCHAR(30) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
// ALTER DATABASE aleman_db CHARACTER SET utf8 COLLATE utf8_general_ci;
// ALTER TABLE customers_tbl CHARACTER SET utf8 COLLATE utf8_general_ci;
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

  Future<MySqlConnection> get connection async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: dbName,
      password: password,
    ));
    return conn;
  }

  Future<bool> initDB() async {
    try {
      await MySqlConnection.connect(ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
      )).then((conn) {
        conn.query(
            "CREATE DATABASE IF NOT EXISTS $dbName CHARACTER SET utf8 COLLATE utf8_general_ci",
            []).then((result) {
          log('the rows length = ${result.length}');
          for (var row in result) {
            log(row[0]);
          }
        });
        conn.close();
      });
      await populateTables();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> populateTables() async {
    await connection.then((conn) {
      conn
          .query(
              "select table_name from $dbName.INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE'")
          .then((result) {
        //TODO: get the result and populate the tables list
      });
    });
  }

  Future<bool> addTable(String tblName, List<DBHeader> headers) async {
    try {
      for (var tbl in _tables) {
        if (tbl.name == tblName) {
          log('table $tblName already created!!');
          return false;
        }
      }
      DBTable custTbl = CustomersDBTbl(
        name: tblName,
        headers: headers,
      );

      log(custTbl.createTableQuary);
      await connection.then((conn) {
        conn.query(custTbl.createTableQuary, []).then((result) {
          log(result.length.toString());
          for (var row in result) {
            log(row[0]);
          }
        });
        conn.close();
      });
      _tables.add(custTbl);
      notifyListeners();

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Stream<Event>> populateTable(List<Tablable> tablables) async {
    // try {
    //   log('try to connect to the database...');
    var eventsStream = await connection.then((conn) async* {
      log('connection to the database succesed');
      log('numb. of tables in the database = ${_tables.length}');
      DBTable table = _tables.where((element) {
        return element.name == CustomersDBTbl.TBL_NAME;
      }).first;
      log('table selected is: ${table.name}');
      String sqlQuery;
      for (var tablable in tablables) {
        sqlQuery = table.addRecord(tablable);
        log(sqlQuery);
        try {
          await conn.query(sqlQuery).then((result) {
            log('resulte: ${result.toString()}');
            for (var row in result) {
              log(row[0]);
            }
          });
          yield Event(state: EventState.done, message: "{$table.name}");
        } on Exception catch (e) {
          log('add record error: ${e.toString()}');
          yield Event(
              state: EventState.error,
              message: 'add record error: ${e.toString()}');
        }
      }
      conn.close();
      yield Event(state: EventState.done, message: "population done.");
      // yield Event(
      //     state: EventState.error,
      //     message: 'population error: ${e.toString()}');
    });
    return eventsStream;
    // } catch (e) {
    //   log('population error: ${e.toString()}');
    // }
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
