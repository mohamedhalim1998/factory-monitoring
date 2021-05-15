import 'dart:async';

import 'package:factory_monitor/data/model/sensor_data.dart';

class SocketData {
  final _socketStream = StreamController<List<Sensor>>.broadcast();

  void addResponse(List<Sensor> data) {
    _socketStream.sink.add(data);
  }

  Stream<List<Sensor>> get getResponse => _socketStream.stream;

  void dispose() {
    _socketStream.close();
  }
}
