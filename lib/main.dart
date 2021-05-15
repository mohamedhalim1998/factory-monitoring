import 'package:factory_monitor/data/data_provider.dart';
import 'package:factory_monitor/screen/sensors_screen.dart';
import 'package:factory_monitor/screen/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(FactoryMonitorApp());
}

class FactoryMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: MaterialApp(
        initialRoute: Sensors.ROUTE_ID,
        routes: {
          Sensors.ROUTE_ID: (context) => Sensors(),
          StatsScreen.ROUTE_ID: (context) => StatsScreen(),
        },
      ),
    );
  }
}
