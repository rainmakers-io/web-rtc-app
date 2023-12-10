import 'dart:core';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';
import 'package:web_rtc_app/utils/MatchingSignaling.dart';
import 'package:permission_handler/permission_handler.dart';

late CtlMatchingRoom ctlMatchingRoom;

class CtlMatchingRoom extends SuperController {
  final Rx<String> _sex = ''.obs;
  final Rx<String> _location = ''.obs;
  final RxList<String> _ageRange = ['14', '99'].obs;
  final _isStartAnimation = false.obs;

  MatchingSignaling? _signaling;
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  var inCalling = false.obs;
  var ableMatching = false.obs;

  get sex {
    return _sex;
  }

  get location {
    return _location;
  }

  get ageRange {
    return _ageRange;
  }

  get isStartAnimation {
    return _isStartAnimation;
  }

  void initRenderer() async {
    await localRenderer.initialize();
  }

  startMatching() {
    if (!ableMatching.value) return;
  }

  Future<bool> isGrantedAllPermissions() async {
    // web은 실제로 사용할 때 권한 허용을 받을 수 있다.
    if (GetPlatform.isDesktop) true;
    // TODO: 권한 허용 요청 다이얼로그 띄우기
    late PermissionStatus cameraStatus;
    late PermissionStatus microphoneStatus;
    do {
      cameraStatus = await Permission.camera.request();
      microphoneStatus = await Permission.microphone.request();
    } while (!(cameraStatus.isGranted && microphoneStatus.isGranted));
    return true;
  }

  void initMatchingFilters() {
    _location.value = localStorage.storage.getString('matching.location') ??
        localStorage.storage.getString('user.location') ??
        ConstantUser.locations[0].$2;
    _ageRange.value =
        localStorage.storage.getStringList('matching.ageRange') ?? ['14', '99'];
    _sex.value = localStorage.storage.getString('matching.sex') ??
        ConstantUser.sexOptions[0].$1;
  }

  void saveMatchingFilters(
      {String? sex, String? location, List<String>? ageRange}) {
    if (sex != null) {
      localStorage.storage.setString('matching.sex', sex);
      _sex.value = sex;
    }
    if (location != null) {
      localStorage.storage.setString('matching.location', location);
      _location.value = location;
    }
    if (ageRange != null) {
      localStorage.storage.setStringList('matching.ageRange', ageRange);
      _ageRange.value = ageRange;
    }
  }

  void onVisible(VisibilityInfo info) async {
    if (GetPlatform.isMobile) {
      Wakelock.enable();
    }
    if (await isGrantedAllPermissions()) {
      initRenderer();
      _signaling ??= MatchingSignaling()..connect();
      _signaling
        ?..init()
        ..onLocalStream = ((stream) {
          localRenderer.srcObject = stream;
          ableMatching.value = true;
        });
      inCalling.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initMatchingFilters();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    print("close");
    super.onClose();
    if (GetPlatform.isMobile) {
      Wakelock.disable();
    }
    if (inCalling.value) {
      off();
    }
  }

  void off() async {
    try {
      if (inCalling.value) {
        _signaling?.dispose();
        inCalling.value = false;
      }
      localRenderer.dispose();
      localRenderer.srcObject = null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onDetached() {
    print("detached");
  }

  @override
  void onInactive() {
    print("inactive");
  }

  @override
  void onPaused() {
    print("paused");
  }

  @override
  void onResumed() async {
    print("resume");
  }

  @override
  void onHidden() {
    print("hidden");
  }
}
