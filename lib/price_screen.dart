import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  static String selectedCurrency = currenciesList[0];
  int BTCRate;
  int ETHRate;
  int LTCRate;

  @override
  void initState() {
    super.initState();
    getCurrenciesRate();
  }

  void getCurrenciesRate() {
    getBTCRate();
    getETHRate();
    getLTCRate();
  }

  void getBTCRate() async {
    var coinData = await CoinData().getCoinData(baseCurrency: cryptoList[0], quoteCurrency: selectedCurrency);

    setState(() {
      BTCRate = coinData['rate'].toInt();
    });
  }

  void getETHRate() async {
    var coinData = await CoinData().getCoinData(baseCurrency: cryptoList[1], quoteCurrency: selectedCurrency);
    setState(() {
      ETHRate = coinData['rate'].toInt();
    });
  }

  void getLTCRate() async {
    var coinData = await CoinData().getCoinData(baseCurrency: cryptoList[2], quoteCurrency: selectedCurrency);
    setState(() {
      LTCRate = coinData['rate'].toInt();
    });
  }

  CupertinoPicker IOSPicker() {
    List<Text> pickerItems = currenciesList.map<Text>((currency) {
      return Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
    }).toList();
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getCurrenciesRate();
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem> dropdownItems = currenciesList.map<DropdownMenuItem<String>>((currency) {
      return DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getCurrenciesRate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrencyCard(
                cryptoCurrency: cryptoList[0],
                currencyRate: BTCRate,
              ),
              CurrencyCard(
                cryptoCurrency: cryptoList[1],
                currencyRate: ETHRate,
              ),
              CurrencyCard(
                cryptoCurrency: cryptoList[2],
                currencyRate: LTCRate,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: IOSPicker(),
            // child: Platform.isIOS ? IOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  CurrencyCard({
    @required this.currencyRate,
    @required this.cryptoCurrency,
  });

  final int currencyRate;
  final String selectedCurrency = _PriceScreenState.selectedCurrency;
  final cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = ${currencyRate ?? "?"} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
