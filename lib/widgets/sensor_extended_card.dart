import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:factory_monitor/util/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class SensorExtendedCard extends StatelessWidget {
  final Sensor sensor;

  const SensorExtendedCard({Key key, this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tempColor = getDangerColor(sensor.temperatureDanger);
    final vibColor = getDangerColor(sensor.vibrationDanger);
    final humidColor = getDangerColor(sensor.humidityDanger);
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sensor.sensorId,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(
                  WeatherIcons.thermometer,
                  color: tempColor,
                  size: 30,
                ),
                title: Text(
                  "Temperature",
                  style: TextStyle(
                    color: tempColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  sensor.temperature.toString(),
                  style: TextStyle(
                    color: tempColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  WeatherIcons.earthquake,
                  color: vibColor,
                  size: 30,
                ),
                title: Text(
                  "Vibration",
                  style: TextStyle(
                    color: vibColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  sensor.vibration.toString(),
                  style: TextStyle(
                    color: vibColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  WeatherIcons.humidity,
                  color: vibColor,
                  size: 30,
                ),
                title: Text(
                  "Humidity",
                  style: TextStyle(
                    color: humidColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  sensor.vibration.toString(),
                  style: TextStyle(
                    color: vibColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.timer,
                  size: 30,
                ),
                title: Text(
                  "Time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  getFormattedDate(sensor.time),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate(int time) {
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(time);
    int diff = DateTime.now().millisecondsSinceEpoch - time;
    if (Duration(milliseconds: diff).inDays < 1)
      return DateFormat.jms().format(toFormat);
    return DateFormat.yMMMd('en_US').format(toFormat);
  }

  Color getDangerColor(int dangerLevel) {
    if (dangerLevel == 0) {
      return kColorSafe;
    } else if (dangerLevel == 1) {
      return kColorWarn;
    } else {
      return kColorDangerous;
    }
  }
}
