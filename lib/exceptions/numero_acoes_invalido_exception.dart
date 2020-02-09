import 'package:flutter/material.dart';
import 'package:toro/exceptions/base_exception.dart';

class NumeroAcoesInvalidoException extends BaseException {
  NumeroAcoesInvalidoException({@required String operacao, @required detalhes})
      : super(
          "Lotes de ações inválidos para concluir a operação",
          operacao,
          detalhes,
        );
}
