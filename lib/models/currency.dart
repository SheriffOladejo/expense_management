import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Currency {
  final String cc;
  final String symbol;
  final String name;

  Currency({this.cc, this.symbol, this.name});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      cc: json['cc'],
      symbol: json['symbol'],
      name: json['name'],
    );
  }
}

Future<List<Currency>> fetchCurrencies() async {
  final jsonString = await rootBundle.loadString('assets/currencies.json');
  List<Currency> currencies = (json.decode(jsonString) as List)
      .map((data) => Currency.fromJson(data))
      .toList();
  return currencies;
}
