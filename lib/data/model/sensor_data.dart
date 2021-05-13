class Sensor {
  int id;
  String sensorId;
  double temperature;
  double vibration;
  int time;
  int dangerLevel;

  Sensor(this.id, this.sensorId, this.temperature, this.vibration, this.time,
      this.dangerLevel);

  Sensor.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sensorId = map['sensorId'];
    this.temperature = map['temperature'].toDouble();
    this.vibration = map['vibration'].toDouble();
    this.time = map['time'];
    this.dangerLevel = map['dangerLevel'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sensorId': sensorId,
      'temperature': temperature,
      'vibration': vibration,
      'time': time,
      'dangerLevel': dangerLevel,
    };
  }
}
