import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toro/cotacoes.dart';
import 'package:toro/deposito.dart';
import 'package:toro/saque.dart';
import 'package:toro/state/carteira_model.dart';
import 'package:toro/state/cotacoes_model.dart';
import 'package:toro/venda.dart';

import 'carteira.dart';
import 'compra.dart';

main() {
  var m = CotacoesModel();
  runApp(
      MultiProvider(
        child: App(),
        providers: [
          ChangeNotifierProvider(
            create: (context) => CarteiraModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => CotacoesModel(),
          ),
        ],
      ),
    );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Toro",
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(),
      ),
      initialRoute: Carteira.route,
      routes: {
        Carteira.route: (c) => Carteira(),
        Compra.route: (c) => Compra(),
        Cotacoes.route: (c) => Cotacoes(),
        Deposito.route: (c) => Deposito(),
        Saque.route: (c) => Saque(),
        Venda.route: (c) => Venda(),
      },
    );
  }
}
