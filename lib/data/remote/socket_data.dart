import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart';


class SocketData {
  final _socketStream = StreamController<List<dynamic>>();

  void addResponse(List<dynamic> s) => _socketStream.sink.add(s);

  Stream<List<dynamic>> get getResponse => _socketStream.stream;


  void dispose() {
    _socketStream.close();
  }
  void connectToSocket() {
    Socket socket = io('http://192.168.1.2:12345',
        OptionBuilder().setTransports(['websocket']).build());
    print('connecting');
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('sensor_data', (data) {
      print(data);
      addResponse(jsonDecode(data)['data']);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }
}
