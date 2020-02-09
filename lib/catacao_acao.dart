import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:toro/custom/typography.dart';
import 'package:toro/custom/valorMonetario.dart';
import 'package:toro/state/carteira_model.dart';
import 'package:toro/state/cotacoes_model.dart';

import 'custom/tratar_erro.dart';

class CompraArguments {
  final String acao;

  CompraArguments(this.acao);
}

class CotacaoAcao extends StatefulWidget {
  static String route = "/compra";

  @override
  _CotacaoAcaoState createState() => _CotacaoAcaoState();
}

class _CotacaoAcaoState extends State<CotacaoAcao> {
  final _valorController = MaskedTextController(mask: "00000000000");

  @override
  Widget build(BuildContext context) {
    CompraArguments arguments =
        ModalRoute.of(context).settings.arguments as CompraArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comprar ${arguments.acao}"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            // Discriminação das ações
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                H1(arguments.acao),
                Consumer<CotacoesModel>(
                  builder: (context, model, child) {
                    var kvp = model.getEntry(arguments.acao);
                    return H1(
                        formatarValorMonetario((kvp.value * 100).toInt()));
                  },
                ),
              ],
            ),
          ),
          Padding(
            // Lotes sob custódia
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text('Quantidade de lotes sub custódia:'),
                Consumer<CarteiraModel>(
                  builder: (context, model, child) => Text(model
                      .getQuantidadeDeLotesDeAcoesSobCustodia(arguments.acao)
                      .toString()),
                )
              ],
            ),
          ),
          Container(
            height: 100.0,
          ),
          Padding(
            // Comprar ações
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: InputDecoration(
                labelText: "Quantidade de lotes para compra",
              ),
            ),
          ),
          Padding(
            // Subtotal
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: H1("Total"),
                ),
                Consumer<CotacoesModel>(
                  builder: (context, model, child) {
                    var quantidadeDeLotes = _valorController.text == ""
                        ? 0
                        : int.parse(_valorController.text);
                    var kvp = model.store.entries
                        .firstWhere((it) => it.key == arguments.acao);
                    return H1(
                      formatarValorMonetario(
                          ((kvp.value * 100 * quantidadeDeLotes).toInt())),
                    );
                  },
                ),
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              Consumer<CarteiraModel>(
                builder: (context, model, child) => FlatButton(
                  onPressed: () {
                    exibirAlertaParaUsuario(
                      () {
                        model.comprar(context, arguments.acao,
                            int.parse(_valorController.text));
                      },
                      context,
                    );
                  },
                  child: Text('Comprar'),
                ),
              ),
              Consumer<CarteiraModel>(
                builder: (context, model, child) => FlatButton(
                  onPressed: () {
                    exibirAlertaParaUsuario(
                      () {
                        model.vender(
                          context,
                          arguments.acao,
                          int.parse(_valorController.text),
                        );
                      },
                      context,
                    );
                  },
                  child: Text('Vender'),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
