from flask import Flask, render_template, session, request, jsonify
from flask_socketio import SocketIO, emit
from flask_sqlalchemy import SQLAlchemy
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import messaging
SAFE = 0
WARNING = 1
DANGEROUS = 2

async_mode = None
app = Flask(__name__)
# app.config['SECRET_KEY'] = 'secret!'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
db = SQLAlchemy(app)
socket_ = SocketIO(app, async_mode=async_mode)


class Sensor(db.Model):
    id = db.Column(db.Integer, primary_key=True,
                   autoincrement=True)
    sensorId = db.Column(db.String(50))
    temperature = db.Column(db.Float)
    temperatureDanger = db.Column(db.Integer)
    vibration = db.Column(db.Float)
    vibrationDanger = db.Column(db.Integer)
    humidity = db.Column(db.Float)
    humidityDanger = db.Column(db.Integer)
    time = db.Column(db.Integer)

    def serialize(sensor):
        return {
            'sensorId': sensor.sensorId,
            'temperature': sensor.temperature,
            'vibration': sensor.vibration,
            'humidity': sensor.humidity,
            'time':  sensor.time,
            'temperatureDanger': sensor.temperatureDanger,
            'vibrationDanger': sensor.vibrationDanger,
            'humidityDanger': sensor.humidityDanger
        }


@app.route('/')
def index():
    return render_template('index.html', async_mode=socket_.async_mode)


@app.route('/sensor-reads', methods=['GET', 'POST'])
def sensor_read():
    if(request.method == 'GET'):
        s = request.args.get('sensorId', '')
        limit = request.args.get('limit', -1)

        if(s == ''):
            data = Sensor.query.order_by(Sensor.time.desc())
        else:
            data = Sensor.query.filter_by(
                sensorId=s).order_by(Sensor.time.desc())
        if(limit != -1):
            data = data.limit(limit)
        else:
            data = data.all()

        data = list(map(Sensor.serialize, data))
        return jsonify(data)
    else:
        return 'placeholder'


def notify(device):
    msg = messaging.Message(notification=messaging.Notification(
        title=device,
        body="device is in dangrous state",),
        topic='danger_notification')
    response = messaging.send(msg)
    # Response is a message ID string.
    print('Successfully sent message:', response)


@socket_.on('sensor_data')
def sensor_data_handler(message):
    list = json.loads(message)['data']
    for map in list:
        print(map)
        sensorId = map['sensorId']
        temperature = map['temperature']
        vibration = map['vibration']
        humidity = map['humidity']
        time = map['time']
        temperatureDanger = map['temperatureDanger']
        vibrationDanger = map['vibrationDanger']
        humidityDanger = map['humidityDanger']
        if(vibrationDanger == DANGEROUS or temperatureDanger == DANGEROUS or humidityDanger == DANGEROUS):
            notify(sensorId)
        sensor = Sensor(sensorId=sensorId,
                        temperature=float(temperature),
                        vibration=float(vibration),
                        humidity=float(humidity),
                        time=time,
                        vibrationDanger=vibrationDanger,
                        temperatureDanger=temperatureDanger,
                        humidityDanger=humidityDanger)
        db.session.add(sensor)
    db.session.commit()
    emit('sensor_data', message, broadcast=True)


if __name__ == '__main__':
    db.create_all()
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred)
    socket_.run(app, host='0.0.0.0', port=12345, debug=True)
