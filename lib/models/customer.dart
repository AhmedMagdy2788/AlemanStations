// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import 'package:aleman_stations/utilities/storage_API/table.dart';

class Customer extends Tablable with ChangeNotifier {
  static const String ID = "id";
  static const String NAME = "customer name";
  static const String INIT_DAPT = "init. dapt";

  late String id;
  String name;
  double initDept;

  Customer({required this.name, required this.initDept}) {
    id = generateId();
  }

  Customer.withID({
    required this.id,
    required this.name,
    required this.initDept,
  });

  @override
  Map<String, dynamic> get toMap {
    return {ID: id, NAME: name, INIT_DAPT: initDept};
  }

  String generateId() {
    return DateTime.now().toString();
  }
}
