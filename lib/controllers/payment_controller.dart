import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.find();
  RxInt paymentAmount = 0.obs;
  RxList<Merchandise> merchandiseList = <Merchandise>[].obs;
  RxMap preds = {}.obs;

  Future<Map> userCurrency(var price) async {
    try {
      var response =
          await dio.Dio().get('http://127.0.0.1:8080/use_currency/${price}');
      var data = jsonDecode(response.data);
      return data;
    } catch (e) {
      print(e);
      return {'error': e};
    }
  }
}

class Merchandise {
  Merchandise({required this.name, required this.price});

  String name;
  int price;
  bool selected = false;
}
