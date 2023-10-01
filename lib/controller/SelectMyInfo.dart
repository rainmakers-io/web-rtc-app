import 'package:get/get.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';

late CtlSelectMyInfo ctlSelectMyInfo;

class CtlSelectMyInfo extends GetxController {
  RxInt _step = 0.obs;
  var _birthDay = DateTime.now().obs;
  var _sex = 'M'.obs; // F or M;
  var _location = ''.obs;
  var _myInterests = [].obs;
  var _purpose = ''.obs;
  var _nickname = ''.obs;
  var _isLoading = false.obs;
  var _profileImageUrl = ''.obs;

  final _steps = [
    const Sex(),
    const BirthDay(),
    const Location(),
    Interests(),
    Purpose(),
    Nickname(),
    const Photo(),
    const Welcome(),
  ];

  get isLoading {
    return _isLoading;
  }

  get step {
    return _step;
  }

  get sex {
    return _sex;
  }

  get steps {
    return _steps;
  }

  get birthDay {
    return _birthDay;
  }

  get location {
    return _location;
  }

  get myInterests {
    return _myInterests;
  }

  get purpose {
    return _purpose;
  }

  get nickname {
    return _nickname;
  }

  get profileImageUrl {
    return _profileImageUrl;
  }

  addInterest(interest) {
    _myInterests.add(interest);
    update();
  }

  removeInterest(interest) {
    _myInterests.remove(interest);
    update();
  }

  createNewUser() {
    // TODO: 입력한 모든 정보를 서버에 기록한다.
  }

  void next() {
    // 환영하기 화면 일경우 받은 모든 정보를 서버에 전달한다.
    if (_step.value == _steps.length - 2) {
      createNewUser();
    }
    _step++;
  }
}
