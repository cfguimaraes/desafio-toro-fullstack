import 'package:flutter/material.dart';

class CarteiraModel extends ChangeNotifier {
  int _saldo = 0;

  int get saldo => _saldo;

  void depositar(double centavos) {
    this._saldo += (centavos * 100).toInt();
    notifyListeners();
  }

  void sacar(double centavos) {
    this._saldo -= (centavos * 100).toInt();
    notifyListeners();
  }
}
