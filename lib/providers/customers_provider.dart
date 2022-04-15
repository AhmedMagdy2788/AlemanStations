import 'package:aleman_stations/utilities/storage_API/storage_handler.dart';
import 'package:flutter/foundation.dart';

import '../utilities/storage_API/table.dart';
import '../models/customer.dart';
// import '../utilities/json/json_providers.dart';

class CustomersProvider with ChangeNotifier {
  // List<Customer> _customersList = [];
  late CustomersTable _cstTable;

  // CustomersProvider() {
  //   Future.delayed(Duration.zero).then((value) => initCustomer());
  // }

  List<Customer> get customers {
    return [..._cstTable.rows];
  }

  Future<List<Customer>> initCustomer(StorageHandler storageHandler) async {
    _cstTable = CustomersTable(storageHandler);
    await _cstTable.initTable();
    // _customersList = _cstTable.rows;
    // _customersList = await JsonProviders().getCustomers();
    notifyListeners();
    return customers;
  }

  void addCustomer(Customer cst) {
    _cstTable.addRow(cst);
    notifyListeners();
  }
}
