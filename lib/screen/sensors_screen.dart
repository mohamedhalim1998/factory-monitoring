import 'package:factory_monitor/data/data_provider.dart';
import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/util/const.dart';
import 'package:factory_monitor/widgets/sensor_card.dart';
import 'package:factory_monitor/widgets/serach_box.dart';
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
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(title: SearchBox()),
      body: SafeArea(
        child: StreamBuilder(
            stream: dataProvider.getLiveDataStream(),
            builder: (context, snapshot) {
              print("recv");
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
                // return GridView.count(
                //   childAspectRatio: .8,
                //   crossAxisCount: 2,
                //   children: buildSensorsDataWidgets(kFakeTestData),
                // );
              } else {
                return GridView.count(
                  childAspectRatio: .8,
                  crossAxisCount: 2,
                  children: buildSensorsDataWidgets(snapshot.data),
                );
              }
            }),
      ),
    );
  }

  List<Widget> buildSensorsDataWidgets(List<Sensor> data) {
    print(data);
    return List.generate(
      data.length,
      (index) {
        return SensorCard(sensor: data[index]);
      },
    );
  }
}
