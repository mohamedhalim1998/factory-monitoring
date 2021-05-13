import socketio
import time
import random
import json


SAFE = 0
WARNING = 1
DANGEROUS = 2


sio = socketio.Client()
sio.connect("http://192.168.1.2:12345")
print('conneced to sever session id', sio.sid)


@sio.on('disconnect')
def disconnect():
    print("Disconnecting ...")
    exit()


if __name__ == '__main__':
    while(1):
        list = []
        for i in range(5):
            sensor = {
                'temperature': random.randint(0, 100),
                'sensorId': "Device #%d" % i,
                'vibration': random.randint(0, 100),
                'time':  int(time.time() * 1000),
            }
            if(sensor['temperature'] > 80 or sensor['vibration'] > 80):
                sensor['dangerLevel'] = DANGEROUS
            elif(sensor['temperature'] > 60 or sensor['vibration'] > 60):
                sensor['dangerLevel'] = WARNING
            else:
                sensor['dangerLevel'] = SAFE
            list.append(sensor)
        print(list)
        try:
            sio.emit("sensor_data", json.dumps({'data': list}))
            time.sleep(5)
        except:
            exit()
