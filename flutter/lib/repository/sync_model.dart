class SyncModel {
  Operacao operacao;
  String payload;

  toMap() => {
        "TIMESTAMP": DateTime.now().toIso8601String(),
        "OPERACAO": operacao.toString(),
        "PAYLOAD": payload
      };
}

enum Operacao { deposito, saque, compra, venda }
