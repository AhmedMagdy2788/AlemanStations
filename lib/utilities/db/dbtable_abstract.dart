// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'db_header.dart';

abstract class DBTable<T> {
  static const String COL_NAME = 'col_name';
  static const String COL_TYPE = 'col_type';
  static const String COL_CONSTRAINS = 'col_constrains';
  final String name;
  final List<DBHeader> headers;
  int rowsCount;
  List<int> primaryKeyIndex = [];

  DBTable({
    required this.name,
    required this.headers,
    // required this.primaryKeyIndex,
    this.rowsCount = 0,
  });

  String get createTableQuary;

  String addRecord(T recordObject);

  Future<List<T>> getAllRecords() async {
    try {
      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> updateRecord(T recordObject) async {
    try {} catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteRecord(T recordObject) async {
    try {} catch (e) {
      log(e.toString());
    }
  }
}
