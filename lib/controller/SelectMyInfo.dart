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
  final Rx<String> _profileImageFile = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _sex.value = localStorage.storage.getString('user.sex') ?? '';
    _birthDay.value =
        DateTime.parse(localStorage.storage.getString('user.birthDay') ?? '');
    _location.value = localStorage.storage.getString('user.location') ?? '';
    _myInterests.value =
        localStorage.storage.getStringList('user.myInterests') ?? [];
    _purpose.value = localStorage.storage.getString('user.purpose') ?? '';
    _nickname.value = localStorage.storage.getString('user.nickname') ?? '';
    _profileImageUrl.value =
        localStorage.storage.getString('user.profileImageUrl') ?? '';
    _step.value = currentStep();
  }

  final _steps = [
    const Sex(),
    const BirthDay(),
    Location(),
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

  get profileImageFile {
    return _profileImageFile;
  }

  // 입력해야될 step으로 이동한다.
  currentStep() {
    for (final (index, value) in [
      _sex.value.isEmpty,
      _birthDay.value.toString().isEmpty,
      _location.value.isEmpty,
      _myInterests.isEmpty,
      _purpose.value.isEmpty,
      _nickname.value.isEmpty,
      _profileImageUrl.value.isEmpty
    ].indexed) {
      if (value) return index;
    }

    return _steps.length - 1;
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
    localStorage.setBool('enableSelectMyInfo', false);
    localStorage.setBool('enableGuide', false);
    // 회원가입

    // 사진 생성
    // _profileImageFile
    // setting
    localStorage.setString('user.profileImageUrl', _profileImageUrl.value);
  }

  void prev() {
    if (_step.value == 0) {
      Get.toNamed('/guide');
      return;
    }
    _step.value--;
  }

  void next() {
    if (_step.value == 0) {
      localStorage.setString('user.sex', _sex.value);
    } else if (_step.value == 1) {
      localStorage.setString('user.birthDay', _birthDay.value.toString());
    } else if (_step.value == 2) {
      localStorage.setString('user.location', _location.value);
    } else if (_step.value == 3) {
      List<String> interests = [];
      for (String interest in _myInterests) {
        interests.add(interest);
      }
      localStorage.setStringList('user.myInterests', interests);
    } else if (_step.value == 4) {
      localStorage.setString('user.purpose', _purpose.value);
    } else if (_step.value == 5) {
      localStorage.setString('user.nickname', _nickname.value);
    } else if (_step.value == 6) {
      createNewUser();
    }

    _step.value++;
  }
}
