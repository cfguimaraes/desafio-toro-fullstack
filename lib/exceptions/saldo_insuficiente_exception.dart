import 'package:flutter/material.dart';

class SaldoInsuficienteException {
  final String message;
  SaldoInsuficienteException({
    @required String operacao,
    @required String detalhes,
  }) : this.message =
            "A sua carteira não tem saldo suficiente para concluir a operação";
}
