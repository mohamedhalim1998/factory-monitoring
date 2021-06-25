import 'package:factory_monitor/data/data_provider.dart';
import 'package:factory_monitor/screen/sensors_screen.dart';
import 'package:factory_monitor/screen/stats_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FactoryMonitorApp());
}

class FactoryMonitorApp extends StatefulWidget {
  @override
  _FactoryMonitorAppState createState() => _FactoryMonitorAppState();
}

class _FactoryMonitorAppState extends State<FactoryMonitorApp> {
  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  initFirebase() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic('danger_notification');
  }

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
