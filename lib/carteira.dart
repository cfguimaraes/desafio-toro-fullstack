import 'package:flutter/material.dart';
import 'package:toro/custom/typography.dart';
import 'package:toro/saque.dart';

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
          H1("R\$ 1548.40"),
          Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Saque.route);
                    },
                    child: Text("Sacar"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Deposito.route);
                    },
                    child: Text("Depositar"),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
