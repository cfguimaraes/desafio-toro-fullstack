import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toro/catacao_acao.dart';
import 'package:toro/custom/valorMonetario.dart';
import 'package:toro/state/cotacoes_model.dart';

class Cotacoes extends StatelessWidget {
  static String route = "/cotacoes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotações'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Consumer<CotacoesModel>(
            builder: (context, model, child) => Column(
              children: model.store.entries
                  .toList()
                  .map(
                    (kvp) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(kvp.key),
                        Text(formatarValorMonetario((kvp.value * 100).toInt())),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              CotacaoAcao.route,
                              arguments: CompraArguments(kvp.key),
                            );
                          },
                          child: Text('Visualizar'),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
