class Sensor {
  int id;
  String sensorId;
  double temperature;
  double vibration;
  double humidity;
  int time;
  int temperatureDanger;
  int vibrationDanger;
  int humidityDanger;

  Sensor(
      this.id,
      this.sensorId,
      this.temperature,
      this.vibration,
      this.humidity,
      this.time,
      this.temperatureDanger,
      this.vibrationDanger,
      this.humidityDanger);

  Sensor.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sensorId = map['sensorId'];
    this.temperature = map['temperature'].toDouble();
    this.vibration = map['vibration'].toDouble();
    this.humidity = map['humidity'].toDouble();
    this.time = map['time'];
    this.temperatureDanger = map['temperatureDanger'];
    this.vibrationDanger = map['vibrationDanger'];
    this.humidityDanger = map['humidityDanger'];
  }

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'sensorId': sensorId,
      'vibration': vibration,
      'humidity': humidity,
      'time': time,
      'temperatureDanger': temperatureDanger,
      'vibrationDanger': vibrationDanger,
      'humidityDanger': humidityDanger
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
