import 'package:get/get.dart';

class PageIndexController extends GetxController {
  static PageIndexController get to => Get.find();

  int index = 0;

  void changePage(int to) {
    index = to;
    update();
  }
}
