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



if __name__ == '__main__':
    list = []
    sensor = {
        'sensorId': "Device #0",
        'temperature': random.randint(0, 50),
        'vibration': 90,
        'time':  int(time.time() * 1000),
    }
    sensor['temperatureDanger'] = DANGEROUS
    sensor['vibrationDanger'] = DANGEROUS
    list.append(sensor)
    for i in range(1, 5):
        sensor = {
            'sensorId': "Device #%d" % i,
            'temperature': random.randint(0, 50),
            'vibration': random.randint(0, 50),
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
        list.append(sensor)
    print(list)
    sio.emit("sensor_data", json.dumps({'data': list}))
    time.sleep(1)
    sio.disconnect()


