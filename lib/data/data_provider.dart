import 'dart:async';
import 'package:factory_monitor/data/remote/socket_data.dart';
import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  SocketData socket = SocketData();

  Stream<List<String>> getLiveDataStream() {
    return socket.getResponse;
  }

}
