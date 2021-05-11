import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:math';

import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:flutter/widgets.dart';

class SocketData {
  final _socketStream = StreamController<List<String>>();

  void addResponse(List<String> s) => _socketStream.sink.add(s);

  Stream<List<String>> get getResponse => _socketStream.stream;

  SocketData() {
    generateFakeData();
  }

  void dispose() {
    _socketStream.close();
  }

  void generateFakeData() async {
    final random = new Random();

    List<String> l = List.generate(5, (index) {
      Sensor s = Sensor('Device' + index.toString(), random.nextDouble() % 50,
          random.nextDouble() % 50, DateTime.now().millisecondsSinceEpoch, 0);
      return jsonEncode(s);
    });
    addResponse(l);
    sleep(Duration(seconds: 5));
  }
}
