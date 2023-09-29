import 'package:get/get.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';

late SelectMyInfoCtl selectMyInfoCtl;
class SelectMyInfoCtl extends GetxController {
  RxInt _step = 0.obs;
  var _birthDay = DateTime.now().obs;
  var sex = 'M'.obs; // F or M;
  var location = ''.obs;

  final _steps = [const Sex(), const BirthDay(), const Location()];

  get step {
    return _step;
  }

  get steps {
    return _steps;
  }

  get birthDay {
    return _birthDay;
  }

  void next() {
    _step.value = (_step.value + 1) % _steps.length;
  }
}