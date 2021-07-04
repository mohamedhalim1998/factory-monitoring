import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:flutter/material.dart';

const kColorSafe = Color(0xFF4F9B4E);
const kColorWarn = Color(0xFFF6AC3C);
const kColorDangerous = Color(0xFFEC524D);
const kColorTheme = Color(0xFF359BCF);
List<Sensor> kFakeTestData = [
  Sensor(25, "Device #0", 25, 35, 30, DateTime.now().millisecondsSinceEpoch, 0,
      0, 0),
  Sensor(25, "Device #1", 63, 40, 40, DateTime.now().millisecondsSinceEpoch, 1,
      0, 0),
  Sensor(25, "Device #2", 85, 35, 25, DateTime.now().millisecondsSinceEpoch, 2,
      0, 0),
];
