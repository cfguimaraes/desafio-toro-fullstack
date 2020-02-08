import 'package:flutter/material.dart';

class CarteiraModel extends ChangeNotifier {
  int _saldo = 0;

  int get saldo => _saldo;

  void depositar(int centavos) {
    this._saldo += centavos;
    notifyListeners();
  }

  void sacar(int centavos) {
    this._saldo -= centavos;
    notifyListeners();
  }
}
