import socketio
import time
import random
import json

def on_aaa_response(args):
    print('sensor_data', args['data'])


sio = socketio.Client()
sio.connect("http://192.168.1.2:12345")
print('my sid is', sio.sid)
while(1):
    list = []
    for i in range(5):
        list.append({
            'temperature': random.randint(0, 100),
            'sensorId': "Device #%d" % i,
            'vibration': random.randint(0, 100),
            'time':  int(time.time() * 1000),
        })
    sio.emit("sensor_data", json.dumps({'data': list}))
    time.sleep(1)
