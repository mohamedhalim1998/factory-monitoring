import 'package:factory_monitor/screen/sensors_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FactoryMonitorApp());
}

class FactoryMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Sensors.ROUTE_ID,
      routes: {
        Sensors.ROUTE_ID: (context) => Sensors(),
      },
    );
  }
}
