import socketio
import time
import random
import json


SAFE = 0
WARNING = 1
DANGEROUS = 2


sio = socketio.Client()
sio.connect("http://192.168.1.5:12345")
print('conneced to sever session id', sio.sid)


@sio.on('disconnect')
def disconnect():
    print("Disconnecting ...")
    exit()


if __name__ == '__main__':
    while(1):
        list = []
        for i in range(3):
            sensor = {
                'sensorId': "Device #%d" % i,
                'temperature': random.randint(30, 60),
                'humidity': random.randint(20, 80),
                'vibration': random.randint(0, 60),
                'time':  int(time.time() * 1000),
            }
            if(sensor['temperature'] > 80):
                sensor['temperatureDanger'] = DANGEROUS
            elif(sensor['temperature'] > 60):
                sensor['temperatureDanger'] = WARNING
            else:
                sensor['temperatureDanger'] = SAFE

            if(sensor['vibration'] > 80):
                sensor['vibrationDanger'] = DANGEROUS
            elif(sensor['vibration'] > 60):
                sensor['vibrationDanger'] = WARNING
            else:
                sensor['vibrationDanger'] = SAFE

            if(sensor['humidity'] > 80):
                sensor['humidityDanger'] = DANGEROUS
            elif(sensor['humidity'] > 60):
                sensor['humidityDanger'] = WARNING
            else:
                sensor['humidityDanger'] = SAFE
            list.append(sensor)
        print(list)
        try:
            sio.emit("sensor_data", json.dumps({'data': list}))
            time.sleep(1)
        except:
            exit()
