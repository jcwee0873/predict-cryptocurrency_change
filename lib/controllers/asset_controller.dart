import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

class AssetController extends GetxController {
  static AssetController get to => Get.find();

  RxMap prices = {}.obs;
  RxMap assets = {}.obs;
  RxDouble amount = 0.0.obs;

  Future<Map>? getCurrencyPrices() async {
    try {
      var response = await dio.Dio().get('http://127.0.0.1:8080/upbit_price');
      var data = jsonDecode(response.data);
      prices.value = data;

      var response2 = await dio.Dio().get('http://127.0.0.1:8080/my_assets');
      var data2 = jsonDecode(response2.data);
      assets.value = data2;

      return prices;
    } catch (e) {
      print(e);
      return prices;
    }
  }

  Future<Map>? getMarketData() async {
    try {
      var response = await dio.Dio().get('http://127.0.0.1:8080/get_market');
      var data = jsonDecode(response.data);
      print(data);
      return data;
    } catch (e) {
      print(e);
      return {'error': e};
    }
  }

  double getAmount() {
    amount.value = 0;
    for (var key in assets.keys) {
      amount.value += assets[key].toInt() * prices[key].toInt();
    }
    return amount.value;
  }
}
