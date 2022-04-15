import 'package:aleman_stations/models/tablable.dart';

abstract class Header<T> {
  bool validateData(Tablable row);
  // {
  //   T cellData = row.toMap[name] as T;
  //   return true;
  // }
}

class HeaderBlock<T> extends Header<T> {
  String name;
  HeaderBlock({required this.name});

  @override
  bool validateData(Tablable row) {
    // TODO: implement validateData
    T cellData = row.toMap[name] as T;
    return true;
    throw UnimplementedError();
  }
}

abstract class HeaderDecorator<T> extends Header<T> {
  HeaderBlock<T> header;
  HeaderDecorator(this.header);
}
