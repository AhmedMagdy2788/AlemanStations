import 'dart:convert';
import 'dart:developer';
import 'package:aleman_stations/models/customer.dart';
import 'package:flutter/services.dart';

import '../../models/marketing_company.dart';

class JsonProviders {
  Future<List<Customer>> getCustomers() async {
    try {
      final String response =
          await rootBundle.loadString('assets/init_data/customers.json');
      final customersData = await json.decode(response);
      List<Customer> customersList = [];
      for (var custData in customersData) {
        customersList.add(Customer(
          name: custData['اسم العميل'],
          initDept: custData['المديونية المبدئية'],
        ));
      }
      return customersList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<MarketingCompany>> gerMarketingComapnies() async {
    try {
      // log("getting companies names");
      final String response = await rootBundle
          .loadString('assets/init_data/waddy_tblMarketingCompanies.json');
      final responseData = await json.decode(response);
      // log(response);
      List<MarketingCompany> companiesList = [];
      for (var compData in responseData) {
        // log("comp. name: {$compData['شركات التسويق']}");
        companiesList.add(MarketingCompany(name: compData['شركات التسويق']));
      }
      return companiesList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
