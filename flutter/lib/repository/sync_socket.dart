import 'dart:io' show WebSocket;

import 'package:flutter/widgets.dart';
import 'package:toro/repository/sync_model.dart';

class SyncSocket {
  WebSocket _webSocket;

  add(SyncModel data) async {
    await _estabelecerConexao();
    _webSocket.add(data.toJson());
  }

  _estabelecerConexao() async {
    if (_webSocket == null) {
      _webSocket = await WebSocket.connect("ws://192.168.0.14:5010");
      // Esperar a conexão abrir
      while (_webSocket.readyState != WebSocket.open) {}
      _webSocket.listen(onData);
    }
  }

  void onData(event) {
    debugPrint(event);
  }
}
