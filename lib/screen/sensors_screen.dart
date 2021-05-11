import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sensors extends StatelessWidget {
  static const String ROUTE_ID = "sensors-screen";
  final random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory Monitor'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            10,
            (index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Device #$index"),
                    Text("Temperature : " + random.nextInt(50).toString()),
                    Text("Vibration Levels : " + random.nextInt(50).toString()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
