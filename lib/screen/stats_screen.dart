import 'package:factory_monitor/data/data_provider.dart';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/util/const.dart';
import 'package:factory_monitor/widgets/data_graph.dart';
import 'package:factory_monitor/widgets/sensor_extended_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  static const String ROUTE_ID = "stats-screen";
  @override
  Widget build(BuildContext context) {
    String sensorId = ModalRoute.of(context).settings.arguments;
    print("$sensorId");
    final dataProvider = context.watch<DataProvider>();
    // Future<List<Sensor>> data = dataProvider.getLatestSensorData(sensorId, 100);
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        title: Text('Factory Monitor'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: dataProvider.getLiveDataStream(),
                  builder: (context, snapshot) {
                    print("recv");
                    if (snapshot.data == null) {
                      return getSensorData(kFakeTestData, sensorId);
                    } else {
                      return getSensorData(snapshot.data, sensorId);
                    }
                  },
                ),
                FutureBuilder(
                    future: getData(dataProvider, sensorId),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return DataGraph(reads: snapshot.data);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSensorData(List<Sensor> data, String sensorId) {
    for (Sensor sensor in data) {
      if (sensor.sensorId == sensorId) {
        return SensorExtendedCard(sensor: sensor);
      }
    }
    return Container();
  }

  Future<List<Sensor>> getData(
      DataProvider dataProvider, String sensorId) async {
    return await dataProvider.getLatestSensorData(sensorId, 100);
  }
}
