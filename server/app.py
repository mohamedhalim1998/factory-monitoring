from flask import Flask, render_template, session, copy_current_request_context
from flask_socketio import SocketIO, emit, disconnect, send
from threading import Lock
from apscheduler.schedulers.background import BackgroundScheduler
import socketio

async_mode = None
app = Flask(__name__)
# app.config['SECRET_KEY'] = 'secret!'
socket_ = SocketIO(app, async_mode=async_mode)
thread = None
thread_lock = Lock()
sio = socketio.Client()


@app.route('/')
def index():
    # init()
    return render_template('index.html', async_mode=socket_.async_mode)


def init():
    print("init")
    scheduler = BackgroundScheduler()
    scheduler.add_job(test_job, 'interval', seconds=5, max_instances=100)
    scheduler.start()


@socket_.on('sensor_data')
def test_sensor_data(message):
    print(message)
    emit('sensor_data', message, broadcast=True)


def test_job():
    socket_.emit('sensor_data', {'data': "send fake"})


if __name__ == '__main__':
    # init()
    # emit('sensor_data', "data", broadcast=True)
    socket_.run(app, host='0.0.0.0', port=12345, debug=True)
