import 'dart:async';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/data/remote/socket_data.dart';
import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  SocketData socketStream = SocketData();

  DataProvider() {
    socketStream.connectToSocket();
  }

  Stream<List<Sensor>> getLiveDataStream() {
    return socketStream.getResponse;
  }
}
