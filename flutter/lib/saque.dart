import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:toro/state/carteira_model.dart';

import 'custom/valorMonetario.dart';

class Saque extends StatefulWidget {
  static String route = "/saque";

  @override
  _SaqueState createState() => _SaqueState();
}

class _SaqueState extends State<Saque> {
  final _valorCtrl = MoneyMaskedTextController(
      decimalSeparator: ",",
      leftSymbol: "R\$ ",
      precision: 2,
      thousandSeparator: ".");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sacar"),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: _valorCtrl,
            decoration: InputDecoration(
              hintText: "R\$ 1234,00",
              labelText: "Valor para sacar",
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
                onPressed: () {
                  _valorCtrl.updateValue(0);
                },
                child: Text("Limpar"),
              ),
              Consumer<CarteiraModel>(
                builder: (context, model, child) => FlatButton(
                  onPressed: () {
                    model.sacar(_valorCtrl.numberValue);
                    var snackbar = SnackBar(
                      content:
                          Text("Saldo ${formatarValorMonetario(model.saldo)}"),
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                    _valorCtrl.clear();
                  },
                  child: Text("Sacar"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
