import 'dart:async';
import 'dart:convert';
import 'package:factory_monitor/data/remote/socket_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DataProvider with ChangeNotifier {
  SocketData socketStream = SocketData();

  DataProvider() {
    socketStream.connectToSocket();
  }

  Stream<List<dynamic>> getLiveDataStream() {
    return socketStream.getResponse;
  }
}
