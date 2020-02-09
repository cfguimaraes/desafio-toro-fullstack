import 'package:intl/intl.dart';

/// O valor é tratado como centavos, portanto para a exibição queremos exibir
/// o valor formatado em decimais.
String formatarValorMonetario(int valor) {
    return NumberFormat.currency(
            locale: "pt-BR", decimalDigits: 2, symbol: "R\$")
        .format(valor / 100);
  }