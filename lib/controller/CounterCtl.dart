import 'package:get/get.dart';

class CounterCtl extends GetxController {
  var counter = 0.obs;

  increment() => counter++;
}