import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toro/cotacoes.dart';
import 'package:toro/custom/typography.dart';
import 'package:toro/saque.dart';
import 'package:toro/state/carteira_model.dart';
import 'package:toro/state/cotacoes_model.dart';

import 'custom/valorMonetario.dart';
import 'deposito.dart';

class Carteira extends StatelessWidget {
  static String route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha carteira"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Saldo da carteira',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Consumer<CarteiraModel>(
                builder: (context, model, child) => H1(
                  formatarValorMonetario(model.saldo),
                ),
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Saque.route);
                },
                child: Text("Sacar"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Deposito.route);
                },
                child: Text("Depositar"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CotacoesModel>(
              builder: (context, model, child) => Table(
                defaultColumnWidth: FlexColumnWidth(),
                children: model.store.entries
                    .take(20)
                    .toList()
                    .map(
                      (kvp) => TableRow(
                        children: <Widget>[
                          Text(kvp.key),
                          Text(formatarValorMonetario(
                              (kvp.value * 100).toInt())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Cotacoes.route);
                },
                child: Text('Ver todas as cotações'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
