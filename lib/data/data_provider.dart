import 'dart:async';
import 'dart:convert';
import 'package:factory_monitor/data/local/db_helper.dart';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/data/remote/network_helper.dart';
import 'package:factory_monitor/data/remote/socket_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DataProvider with ChangeNotifier {
  SocketData socketStream = SocketData();
  DatabaseHelper database = DatabaseHelper.instance;
  NetworkHelper networkHelper = NetworkHelper.instance;

  DataProvider() {
    connectToSocket();
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

  void connectToSocket() {
    Socket socket = io('http://192.168.1.2:12345',
        OptionBuilder().setTransports(['websocket']).build());
    print('connecting');
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('sensor_data', (data) {
      print(data);
      sendDataToStream(jsonDecode(data)['data']);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  void sendDataToStream(data) async {
    List<Sensor> sensors = List.generate(
      data.length,
      (index) {
        print(data[index]);
        Sensor sensor = Sensor.fromMap(data[index]);
        return sensor;
      },
    );
    for (Sensor sensor in sensors) {
      database.insert(sensor);
    }
    socketStream.addResponse(sensors);
  }
}
