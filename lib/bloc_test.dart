import 'dart:async';

import 'package:aleman_stations/utilities/storage_API/storage_event.dart';

class Bloc<T> {
  late T _data;
  final StreamController<T> _outStreamController = StreamController<T>();
  StreamSink<T> get _outStreamSink => _outStreamController.sink;
  Stream<T> get outStream => _outStreamController.stream;

  final StreamController<Event> _eventStreamController =
      StreamController<Event>();
  StreamSink<Event> get eventStreamSink => _eventStreamController.sink;
  Bloc({required T initData}) {
    _data = initData;
    _eventStreamController.stream.listen((event) {
      //TODO: modify the _data based on the event type
      _outStreamSink.add(_data);
    });
  }

  void dispose() {
    _outStreamController.close();
    _eventStreamController.close();
  }
}
