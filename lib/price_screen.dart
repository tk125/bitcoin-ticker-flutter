import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'dart:io' show Platform;
import 'services/coin.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String amount = '?';
  dynamic coinJSONData;
  CoinModel coinModel = CoinModel();

  @override
  void initState() {
    // TODO: implement initState
    // getCoinPrice(1);
    super.initState();
  }

  DropdownButton<String> getDropdownButton() {
    //create dropdownlist
    List<DropdownMenuItem<String>> currencyMenu = [];
    for (String currency in currenciesList) {
      currencyMenu.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    //create button
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyMenu,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(value);
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    //create option list
    List<Text> currencies = [];
    for (String currency in currenciesList) {
      currencies.add(Text(currency));
    }

    return CupertinoPicker(
      //height of the picker
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        getCoinPrice(selectedIndex);
      },
      children: currencies,
    );
  }

  Widget getCorrectPicker() {
    if (Platform.isIOS) {
      return getIOSPicker();
    } else {
      return getDropdownButton();
    }
  }

  void getCoinPrice(int selectedIndex) async {
    selectedCurrency = currenciesList.elementAt(selectedIndex);
    coinJSONData = await coinModel.getCoinPrice('BTC', selectedCurrency);
    print('hi${coinJSONData['rate']}');
    setState(() {
      print(selectedIndex);
      amount = coinJSONData['rate'].toStringAsFixed(2);
    });
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
          Padding(
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
                  '1 BTC = $amount $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getIOSPicker(),
          ),
        ],
      ),
    );
  }
}
