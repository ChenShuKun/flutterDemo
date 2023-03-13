import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  var name = "".obs;
  void increase() {
    count++;
  }
}
