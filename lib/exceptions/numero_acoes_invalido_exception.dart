import 'package:flutter/material.dart';

class NumeroAcoesInvalidoException {
  final String message;

  NumeroAcoesInvalidoException({@required String operacao, @required detalhes})
      : this.message = "Lotes de ações inválidos para concluir a operação";
}
