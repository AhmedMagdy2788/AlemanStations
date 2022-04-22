// ignore_for_file: constant_identifier_names

import 'package:aleman_stations/utilities/storage_API/table.dart';
import 'package:flutter/foundation.dart';

class MarketingCompany extends Tablable with ChangeNotifier {
  static const String NAME = "name";
  static const String ADDRESS = "address";
  static const String PHONE_NUMBER = "phone_number";
  static const String FAX_NUMBER = "fax_number";
  static const String EMAIL = "email";

  String name;
  String? address;
  int? phoneNumber;
  int? fax;
  String? email;

  MarketingCompany({
    required this.name,
    this.address,
    this.email,
    this.fax,
    this.phoneNumber,
  });

  @override
  Map<String, dynamic> get toMap {
    return {
      NAME: name,
      ADDRESS: address,
      PHONE_NUMBER: phoneNumber,
      FAX_NUMBER: fax,
      EMAIL: email,
    };
  }
}
