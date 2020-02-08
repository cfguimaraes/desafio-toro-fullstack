import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toro/custom/typography.dart';
import 'package:toro/saque.dart';
import 'package:toro/state/carteira_model.dart';

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
          Center(
            child: Consumer<CarteiraModel>(
              builder: (context, model, child) => H1(
                formatarValorMonetario(model.saldo),
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
          )
        ],
      ),
    );
  }
}
