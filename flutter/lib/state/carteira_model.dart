import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toro/custom/valorMonetario.dart';
import 'package:toro/exceptions/numero_acoes_invalido_exception.dart';
import 'package:toro/exceptions/saldo_insuficiente_exception.dart';
import 'package:toro/state/cotacoes_model.dart';

class CarteiraModel extends ChangeNotifier {
  int _saldo = 0;
  Map<String, int> _acoes = new Map();

  int get saldo => _saldo;

  void depositar(double centavos) {
    this._saldo += (centavos * 100).toInt();
    notifyListeners();
  }

  void sacar(double centavos) {
    this._saldo -= (centavos * 100).toInt();
    notifyListeners();
  }

  /// Efetuar a compra do lote desejado.
  /// {@param [context]} BuildContext que contém a instância do provider [CotacoesModel]
  /// {@param [acao]} Nome da ação a ser comprada
  /// {@param [lotes]} Quantidade de lotes para comprar
  ///
  /// [SaldoInsuficienteException] Quando o valor do saldo em carteira não for suficiente para a compra do lote
  void comprar(BuildContext context, String acao, int lotes) {
    var cotacoesModel = Provider.of<CotacoesModel>(context, listen: false);
    var papel = cotacoesModel.getEntry(acao);
    var valorTotalDaCompra = ((papel.value * 100).toInt()) * lotes;

    _validaSeTemSaldoEmCarteiraParaCompraDaAcao(
        valorTotalDaCompra, lotes, acao);

    // Registrar evento de compra de ações
    this._saldo -= valorTotalDaCompra; // Deduz do seu saldo o valor da operação
    this._acoes.containsKey(acao) // Se já tem a chave incrementa, senão seta
        ? this._acoes[acao] += lotes
        : this._acoes[acao] =
            lotes; // Incrementa a quantidade de lotes sob posse
    notifyListeners();
  }

  /// Efetuar a venda do lote desejado.
  /// {@param [context]} BuildContext que contém a instância do provider [CotacoesModel]
  /// {@param [acao]} Nome da ação a ser comprada
  /// {@param [lotes]} Quantidade de lotes para comprar
  ///
  /// [SaldoInsuficienteException] Quando o valor do saldo em carteira não for suficiente para a compra do lote
  void vender(BuildContext context, String acao, int lotes) {
    var cotacoesModel = Provider.of<CotacoesModel>(context, listen: false);
    var papel = cotacoesModel.getEntry(acao);
    var valorTotalDaVenda = ((papel.value * 100).toInt()) * lotes;

    // Registrar evento de venda de ações

    // Se não tiver ações para vender deve lançar exceção

    var quantidadeDeAcoesDisponiveis = (this._acoes ?? const {})[acao] ?? 0;
    if (lotes > quantidadeDeAcoesDisponiveis) {
      throw NumeroAcoesInvalidoException(
          operacao: "Venda de $lotes da ação $acao",
          detalhes:
              "Quantidade de lotes disponíveis: $quantidadeDeAcoesDisponiveis" +
                  "\nQuantidade solicitada $lotes");
    }

    this._saldo += valorTotalDaVenda;
    this._acoes[acao] -= lotes;
    notifyListeners();
  }

  void _validaSeTemSaldoEmCarteiraParaCompraDaAcao(
      int valorTotalDaCompra, int lotes, String acao) {
    if (valorTotalDaCompra > this.saldo) {
      throw SaldoInsuficienteException(
          operacao: "Compra de $lotes lotes da ação $acao.",
          detalhes: "Saldo disponível: ${this._saldo}." +
              "\nValor da operação: ${formatarValorMonetario(valorTotalDaCompra)}");
    }
  }

  int getQuantidadeDeLotesDeAcoesSobCustodia(String acao) {
    return (this._acoes ?? const {})[acao] ?? 0;
  }
}
