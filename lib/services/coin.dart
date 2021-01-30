import 'dart:convert';

import 'package:bitcoin_ticker/utitlities/constants.dart';
import 'networking.dart';

class CoinModel {
  String coin;
  String currency;

  CoinModel({this.coin, this.currency});

  Future<dynamic> getCoinPrice(String coin, String currency) async {
    var url = '$coinapiURL/$coin/$currency/?apikey=$apiKey';
    NetworkingHelper networkingHelper = NetworkingHelper(url);
    var returnJson = await networkingHelper.getData();
    return jsonDecode(returnJson);
  }
}
