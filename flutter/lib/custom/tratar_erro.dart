import 'package:flutter/material.dart';
import 'package:toro/exceptions/base_exception.dart';

void exibirAlertaParaUsuario(Function method, BuildContext context) {
  try {
    method();
  } on BaseException catch (e) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(e.message),
            content: Text(e.operacao + "\n" + e.detalhes),
          );
        });
  }
}
