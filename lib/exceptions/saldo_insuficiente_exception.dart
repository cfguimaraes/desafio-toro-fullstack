import 'package:flutter/material.dart';

class SaldoInsuficienteException {
  final String message;
  final String operacao;
  final String detalhes;
  SaldoInsuficienteException({
    @required this.operacao,
    @required this.detalhes,
  }) : this.message =
            "A sua carteira não tem saldo suficiente para concluir a operação";
}
