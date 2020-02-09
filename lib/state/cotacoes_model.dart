import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CotacoesModel extends ChangeNotifier {
  final _socket = IOWebSocketChannel.connect("ws://192.168.0.14:8080/quotes");
  final store = SplayTreeMap<String, double>();

  CotacoesModel() {
    _socket.stream.listen((data) {
      Map decoded = jsonDecode(data);
      _storeValue(decoded);
      notifyListeners();
    });
  }

  MapEntry<String, double> getEntry(String acao) =>
      store.entries.firstWhere((it) => it.key == acao);

  void _storeValue(Map<String, dynamic> data) {
    data.remove("timestamp");
    this.store[data.keys.first] = data.values.first;
  }
}
