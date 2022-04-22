import 'dart:developer';

// import 'package:aleman_stations/models/customer.dart';
import 'package:aleman_stations/models/marketing_company.dart';
import 'package:aleman_stations/utilities/db/db_header.dart';
import 'package:aleman_stations/utilities/db/dbtable_abstract.dart';
import 'package:aleman_stations/utilities/json/json_providers.dart';
import 'package:aleman_stations/utilities/storage_API/storage_event.dart';
import 'package:aleman_stations/utilities/storage_API/table.dart';
import 'package:flutter/foundation.dart';
import '../db/db_server.dart';

class StorageHandler with ChangeNotifier {
  bool isInit = false;
  late DBServer _dbServer;
  late JsonProviders _jsonProviders;

  Future<bool> initStorages() async {
    log('initializing db server and get json data');
    _dbServer = DBServer(
      host: "localhost",
      port: 3306,
      dbName: "aleman_db",
      user: "root",
      password: "Admin@div88",
    );
    _jsonProviders = JsonProviders();
    isInit = true;
    return await _dbServer.initDB();
  }

  Future<List<Tablable>> getTable(Table tabel) async {
    try {
      return await _jsonProviders.getCustomers();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> populateTableFromJson(String tblName) async {
    try {
      List<Tablable> customers = await _jsonProviders.getCustomers();
      log('numb. of customers = ${customers.length}');
      Stream<Event> stream = await _dbServer.populateTable(customers);
      stream.listen((event) {
        log(event.toString());
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> createTable(String tblName, List<DBHeader> headers) async {
    try {
      final result = await _dbServer.addTable(tblName, headers);
      return result;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
