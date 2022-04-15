import 'dart:convert';
import 'package:aleman_stations/models/customer.dart';
import 'package:flutter/services.dart';

class JsonProviders {
  Future<List<Customer>> getCustomers() async {
    final String response =
        await rootBundle.loadString('assets/init data/customers.json');
    final customersData = await json.decode(response);
    List<Customer> customersList = [];
    for (var custData in customersData) {
      customersList.add(Customer(
        name: custData['اسم العميل'],
        initDept: custData['المديونية المبدئية'],
      ));
    }
    return customersList;
  }
}
