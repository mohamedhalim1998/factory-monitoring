class Sensor {
  int id;
  String sensorId;
  double temperature;
  double vibration;
  int time;
  int temperatureDanger;
  int vibrationDanger;

  Sensor(this.id, this.sensorId, this.temperature, this.vibration, this.time,
      this.temperatureDanger, this.vibrationDanger);

  Sensor.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sensorId = map['sensorId'];
    this.temperature = map['temperature'].toDouble();
    this.vibration = map['vibration'].toDouble();
    this.time = map['time'];
    this.temperatureDanger = map['temperatureDanger'];
    this.vibrationDanger = map['vibrationDanger'];
  }

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'sensorId': sensorId,
      'vibration': vibration,
      'time': time,
      'temperatureDanger': temperatureDanger,
      'vibrationDanger': vibrationDanger
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
