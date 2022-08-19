import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '3A2D2D79-D180-4899-A843-EBB4160345E0';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData({String baseCurrency, String quoteCurrency}) async {
    http.Response response = await http.get('$coinAPIURL/$baseCurrency/$quoteCurrency?apikey=$apiKey');
    print('=======================');
    if (response.statusCode == 200) {
      var coinData = jsonDecode(response.body);
      print(coinData);
      return coinData;
    } else
      print(response.statusCode);
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
