import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:toro/custom/valorMonetario.dart';
import 'package:toro/state/carteira_model.dart';

class Deposito extends StatefulWidget {
  static String route = "/deposito";

  @override
  _DepositoState createState() => _DepositoState();
}

class _DepositoState extends State<Deposito> {
  final _valorCtrl = MoneyMaskedTextController(
      decimalSeparator: ",",
      leftSymbol: "R\$ ",
      precision: 2,
      thousandSeparator: ".");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Depositar"),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: _valorCtrl,
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
                onPressed: () {
                  _valorCtrl.clear();
                },
                child: Text("Limpar"),
              ),
              Consumer<CarteiraModel>(
                builder: (context, model, child) => FlatButton(
                  onPressed: () {
                    model.depositar((_valorCtrl.numberValue * 100).toInt());
                    var snackbar = SnackBar(
                      content:
                          Text("Saldo ${formatarValorMonetario(model.saldo)}"),
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                    _valorCtrl.updateValue(0);
                  },
                  child: Text("Depositar"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
