import 'package:flutter/material.dart';

class Deposito extends StatelessWidget {
  static String route = "/deposito";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Depositar"),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "R\$ 1234,00",
              labelText: "Valor",
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar e voltar"),
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Limpar"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Depositar"),
              )
            ],
          )
        ],
      ),
    );
  }
}
