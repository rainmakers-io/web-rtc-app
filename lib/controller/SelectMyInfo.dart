import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';
import 'package:web_rtc_app/widgets/dialog/AlertDefault.dart';

late CtlSelectMyInfo ctlSelectMyInfo;

enum Steps {
  sex,
  birthday,
  location,
  myInterests,
  purpose,
  nickname,
  profileImage,
  welcome,
  last,
}

class CtlSelectMyInfo extends GetxController {
  final RxInt _step = 0.obs;
  final Rx<DateTime> _birthDay = DateTime.now().obs;

  /// FEMALE or MALE;
  final Rx<String> _sex = ''.obs;
  final Rx<String> _location = ''.obs;
  final RxList _myInterests = [].obs;
  final Rx<String> _purpose = ''.obs;
  final Rx<String> _nickname = ''.obs;
  final RxBool _isLoading = false.obs;
  final Rx<String> _profileImageFileString = ''.obs;
  late List<String> _profileImageUrls;
  XFile? profileImageFile;

  @override
  void onReady() {
    super.onReady();
    _sex.value = localStorage.storage.getString('user.sex') ?? '';
    _location.value = localStorage.storage.getString('user.location') ?? '';
    _myInterests.value =
        localStorage.storage.getStringList('user.myInterests') ?? [];
    _purpose.value = localStorage.storage.getString('user.purpose') ?? '';
    _nickname.value = localStorage.storage.getString('user.nickname') ?? '';
    _profileImageUrls =
        localStorage.storage.getStringList('user.profileImageUrl') ?? [];
    try {
      _birthDay.value =
          DateTime.parse(localStorage.storage.getString('user.birthDay') ?? '');
    } catch (e) {
      rethrow;
    }
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

  get profileImageFileString {
    return _profileImageFileString;
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
      _profileImageUrls.isEmpty,
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

  createNewUser() async {
    // 회원가입
    try {
      var res = await apiProvider.authService.createAccount({
        "gender": _sex.value,
        "nickname": _nickname.value,
        "birth": _birthDay.value.toIso8601String().split('T').first,
        "location": [_location.value],
        "interests": _myInterests.map((element) => element.toString()).toList(),
        "purpose": _purpose.value,
      });
      switch (res["statusCode"]) {
        case 400:
        case 500:
          {
            // 데이터 포맷 에러
            DialogAlertDefault.show(
                title: '일시적인 에러로 서비스를 이용할 수 없습니다.\n잠시후 다시 시도해주세요.',
                content: '에러가 지속될 시 "abcd@naver.com"으로 문의주시면 빠르게 해결하겠습니다.');
          }
      }
    } catch (error) {
      DialogAlertDefault.show(
          title: '일시적인 에러로 서비스를 이용할 수 없습니다.\n잠시후 다시 시도해주세요.',
          content: '에러가 지속될 시 "abcd@naver.com"으로 문의주시면 빠르게 해결하겠습니다.');
      rethrow;
    }
    
    // TODO: 로그인


    // 사진 저장
    try {
      if (profileImageFile == null) {
        DialogAlertDefault.show(title: '프로파일 이미지가 존재하지 않습니다. 새로운 이미지를 추가해주세요.');
        _step.value = Steps.profileImage.index;
      }
      var res =
          await apiProvider.imageService.addImages([profileImageFile!.path]);
      switch (res["statusCode"]) {
        case 400:
        case 401:
          {
            DialogAlertDefault.show(
                title: '일시적인 에러로 서비스를 이용할 수 없습니다.\n잠시후 다시 시도해주세요.',
                content: '에러가 지속될 시 "abcd@naver.com"으로 문의주시면 빠르게 해결하겠습니다.');
          }
        case 409:
          {
            DialogAlertDefault.show(
                title: '중복된 이미지가 존재합니다.', content: '다른 프로필 사진으로 변경해주세요.');
            _step.value = Steps.profileImage.index;
          }
      }
      localStorage.setStringList(
          'user.profileImageUrl', List<String>.from(res["urls"]));
      localStorage.setBool('enableSelectMyInfo', false);
      localStorage.setBool('enableGuide', false);
    } catch (error) {
      DialogAlertDefault.show(
          title: '일시적인 에러로 서비스를 이용할 수 없습니다.\n잠시후 다시 시도해주세요.',
          content: '에러가 지속될 시 "abcd@naver.com"으로 문의주시면 빠르게 해결하겠습니다.');
      rethrow;
    }
  }

  void prev() {
    if (_step.value == Steps.sex.index) {
      Get.toNamed('/guide');
      return;
    }
    _step.value--;
  }

  void next() {
    int prevStep = _step.value;
    if (prevStep == Steps.sex.index) {
      localStorage.setString('user.sex', _sex.value);
    } else if (prevStep == Steps.birthday.index) {
      localStorage.setString('user.birthDay', _birthDay.value.toString());
    } else if (prevStep == Steps.location.index) {
      localStorage.setString('user.location', _location.value);
    } else if (prevStep == Steps.myInterests.index) {
      localStorage.setStringList('user.myInterests',
          _myInterests.map((element) => element.toString()).toList());
    } else if (prevStep == Steps.purpose.index) {
      localStorage.setString('user.purpose', _purpose.value);
    } else if (prevStep == Steps.nickname.index) {
      localStorage.setString('user.nickname', _nickname.value);
    } else if (prevStep == Steps.profileImage.index) {
      // NOTE: 이미지는 용량 이슈로 인해 유저 생성시 이미지 로컬스토리지에 저장.
      createNewUser();
    }

    _step.value++;
  }
}
