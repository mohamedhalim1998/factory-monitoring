class Sensor {
  String sensorId;
  double temperature;
  double vibration;
  int time;
  int color;

  Sensor(this.sensorId, this.temperature, this.vibration, this.time,
      this.color);

  Sensor.fromMap(Map<String, dynamic> map) {
    this.sensorId = map['sensorId'];
    this.temperature = map['temperature'];
    this.vibration = map['vibration'];
    this.time = map['time'];
    this.color = map['color'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sensorId': sensorId,
      'temperature': temperature,
      'vibration': vibration,
      'time': time,
      'color': color,
    };
  }
}
