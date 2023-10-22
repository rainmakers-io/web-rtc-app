import 'package:get/get.dart';

late CtlGuide ctlGuide;

class CtlGuide extends GetxController {
  final RxString _buttonText = '다음'.obs;

  get buttonText {
    return _buttonText;
  }
}