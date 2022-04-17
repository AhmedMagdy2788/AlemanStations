import 'dart:developer';

import 'package:aleman_stations/utilities/storage_API/header.dart';
import 'package:aleman_stations/utilities/storage_API/storage_handler.dart';

import '../../models/customer.dart';

abstract class Tablable {
  Map<String, dynamic> get toMap;
}

abstract class Table<Tablable> {
  final String tblName;
  StorageHandler storageHandler;
  final List<HeaderBlock> headers;
  late List<Tablable> rows;
  Table({
    required this.storageHandler,
    required this.tblName,
    required this.headers,
  });
  Future<bool> initTable();
  Future<bool> addRow(Tablable data);
  Future<bool> removeRow(Tablable data);
}

class CustomersTable extends Table<Customer> {
  CustomersTable(StorageHandler storageHandler)
      : super(
            storageHandler: storageHandler,
            tblName: "tblCustomers",
            headers: [
              HeaderBlock<String>(name: Customer.ID),
              HeaderBlock<String>(name: Customer.NAME),
              HeaderBlock<double>(name: Customer.INIT_DAPT),
            ]);

  @override
  Future<bool> initTable() async {
    try {
      rows = await storageHandler.getTable(this) as List<Customer>;
      for (HeaderBlock header in headers) {
        for (Tablable row in rows) {
          header.validateData(row);
        }
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> addRow(Customer data) {
    // TODO: implement addRow
    throw UnimplementedError();
  }

  @override
  Future<bool> removeRow(Customer data) {
    // TODO: implement removeRow
    throw UnimplementedError();
  }
}
