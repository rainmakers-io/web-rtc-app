import 'package:get/get.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

late CtlSelectMyInfo ctlSelectMyInfo;

class CtlSelectMyInfo extends GetxController {
  final RxInt _step = 0.obs;
  final Rx<DateTime> _birthDay = DateTime.now().obs;
  final Rx<String> _sex = ''.obs; // F or M;
  final Rx<String> _location = ''.obs;
  final RxList _myInterests = [].obs;
  final Rx<String> _purpose = ''.obs;
  final Rx<String> _nickname = ''.obs;
  final RxBool _isLoading = false.obs;
  final Rx<String> _profileImageUrl = ''.obs;

  constructor() {
    // TODO:
    // storage에 저장된 정보를 받는다.
    // next를 변경한다.
  }

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
    localStorage.setString('user.sex', _sex.value);
    localStorage.setString('user.birthDay', _birthDay.value.toString());
    localStorage.setString('user.location', _location.value);
    List<String> interests = [];
    for (String interest in _myInterests) {
      interests.add(interest);
    }
    localStorage.setStringList('user.myInterests', interests);
    localStorage.setString('user.purpose', _purpose.value);
    localStorage.setString('user.nickname', _nickname.value);
    localStorage.setString('user.profileImageUrl', _profileImageUrl.value);
    localStorage.setBool('enableSelectMyInfo', false);
    localStorage.setBool('enableGuide', false);

    // 환영하기 화면일 경우 받은 모든 정보를 서버에 전달한다.
    if (_step.value == _steps.length - 2) {
      createNewUser();
    }
    _step.value++;
  }
}
