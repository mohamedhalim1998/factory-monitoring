
import 'package:factory_monitor/data/data_provider.dart';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Sensors extends StatelessWidget {
  static const String ROUTE_ID = "sensors-screen";

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();
    print(dataProvider);
    // dataProvider.connectToSocket();
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory Monitor'),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: dataProvider.getLiveDataStream(),
            builder: (context, snapshot) {
              print("recv");
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.count(
                  crossAxisCount: 2,
                  children: buildSensorsData(snapshot.data),
                );
              }
            }),
      ),
    );
  }

  List<Widget> buildSensorsData(List<dynamic> data) {
    print(data);
    return List.generate(
      data.length,
      (index) {
        print(data[index]);
        var sensor = Sensor.fromMap(data[index]);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(sensor.sensorId),
              Text("Temperature : " + sensor.temperature.toString()),
              Text("Vibration Levels : " + sensor.vibration.toString()),
            ],
          ),
        );
      },
    );
  }
}
