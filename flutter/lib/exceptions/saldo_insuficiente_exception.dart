import 'package:flutter/material.dart';
import 'package:toro/exceptions/base_exception.dart';

class SaldoInsuficienteException extends BaseException {
  SaldoInsuficienteException({
    @required operacao,
    @required detalhes,
  }) : super(
          "A sua carteira não tem saldo suficiente para concluir a operação",
          operacao,
          detalhes,
        );
}
