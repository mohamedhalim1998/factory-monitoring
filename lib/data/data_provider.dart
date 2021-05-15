import 'dart:async';
import 'package:factory_monitor/data/local/db_helper.dart';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/data/remote/network_helper.dart';
import 'package:factory_monitor/data/remote/socket_data.dart';
import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  SocketData socketStream = SocketData();
  DatabaseHelper database = DatabaseHelper.instance;
  NetworkHelper networkHelper = NetworkHelper.instance;

  DataProvider() {
    socketStream.connectToSocket();
    updateCache();
  }

  Stream<List<Sensor>> getLiveDataStream() {
    return socketStream.getResponse;
  }

  void updateCache() async {
    List<Sensor> data = await networkHelper.fetchAll();
    for (Sensor sensor in data) {
      database.insert(sensor);
    }
  }

  Future<List<Sensor>> getLatestSensorData(String sensorId, int limit) async {
    print("$sensorId , $limit");
    var data = await database.getLatestSensorData(sensorId, limit);
    print(data);
    return data.map((e) => Sensor.fromMap(e)).toList();
  }
}
