from flask import Flask, render_template, session, request, jsonify
from flask_socketio import SocketIO, emit
from threading import Lock
from flask_sqlalchemy import SQLAlchemy
import json

async_mode = None
app = Flask(__name__)
# app.config['SECRET_KEY'] = 'secret!'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
db = SQLAlchemy(app)
socket_ = SocketIO(app, async_mode=async_mode)
thread = None
thread_lock = Lock()


class Sensor(db.Model):
    id = db.Column(db.Integer, primary_key=True,
                   autoincrement=True)
    temperature = db.Column(db.Float)
    sensorId = db.Column(db.String(50))
    vibration = db.Column(db.Float)
    time = db.Column(db.Integer)
    dangerLevel = db.Column(db.Integer)

    def serialize(sensor):
        return {
            'temperature': sensor.temperature,
            'sensorId': sensor.sensorId,
            'vibration': sensor.vibration,
            'time':  sensor.time,
            'dangerLevel': sensor.dangerLevel
        }


@app.route('/')
def index():
    return render_template('index.html', async_mode=socket_.async_mode)


@socket_.on('sensor_data')
def test_sensor_data(message):
    list = json.loads(message)['data']
    for map in list:
        print(map)
        sensorId = map['sensorId']
        temperature = map['temperature']
        vibration = map['vibration']
        time = map['time']
        dangerLevel = map['dangerLevel']
        sensor = Sensor(sensorId=sensorId, temperature=float(temperature),
                        vibration=float(vibration), time=time, dangerLevel=dangerLevel)
        db.session.add(sensor)

    db.session.commit()
    emit('sensor_data', message, broadcast=True)


if __name__ == '__main__':
    db.create_all()
    socket_.run(app, host='0.0.0.0', port=12345, debug=True)
