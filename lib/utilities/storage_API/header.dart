import 'package:aleman_stations/utilities/storage_API/table.dart';

abstract class Header<T> {
  bool validateData(Tablable row);
}

class HeaderBlock<T> extends Header<T> {
  String name;
  HeaderBlock({required this.name});

  @override
  bool validateData(Tablable row) {
    T cellData = row.toMap[name] as T;
    return true;
  }
}

abstract class HeaderDecorator<T> extends Header<T> {
  Header<T> header;
  HeaderDecorator(this.header);
}

enum DateValidations {
  equelsTo,
  notEquelsTo,
  lessThan,
  greaterThan,
  lessThanOrEquelsTo,
  greaterThanOrEquelsTo
}

class DateValidatorDecorator<DateTime> extends HeaderDecorator<DateTime> {
  DateValidations validationType;
  DateValidatorDecorator(
      {required Header<DateTime> header, required this.validationType})
      : super(header);

  @override
  bool validateData(Tablable row) {
    // TODO: implement validateData
    throw UnimplementedError();
  }
}
