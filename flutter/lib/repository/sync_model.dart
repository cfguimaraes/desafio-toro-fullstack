class SyncModel {
  Operacao operacao;
  String payload;
  String _timestamp;

  SyncModel(this.operacao, this.payload)
      : this._timestamp = DateTime.now().toIso8601String();

  toMap() => {
        "TIMESTAMP": _timestamp,
        "PAYLOAD": payload,
        "OPERACAO": operacao.toString(),
        "DATA_SINCRONIA": _timestamp,
      };
}

enum Operacao { deposito, saque, compra, venda }
