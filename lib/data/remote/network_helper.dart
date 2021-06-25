import 'dart:convert';

import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static final NetworkHelper instance = NetworkHelper._constructor();
  NetworkHelper._constructor();
  Future<List<Sensor>> fetchAll() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.5:12345/sensor-reads"));
    List<dynamic> data = jsonDecode(response.body);
    return List.generate(data.length, (index) => Sensor.fromMap(data[index]));
  }
}
