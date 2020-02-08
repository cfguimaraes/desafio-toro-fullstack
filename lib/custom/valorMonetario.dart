import 'package:intl/intl.dart';

String formatarValorMonetario(int valor) {
    return NumberFormat.currency(
            locale: "pt-BR", decimalDigits: 2, symbol: "R\$")
        .format(valor);
  }