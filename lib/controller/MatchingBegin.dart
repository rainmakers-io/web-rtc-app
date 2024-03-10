import 'dart:core';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/pages/Matching.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';
import 'package:web_rtc_app/utils/MatchingSignaling.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

late CtlMatchingBegin ctlMatchingBegin;

// TODO: 홈 버튼 클릭하여 나갔다가 재접속시 화면/애니메이션 실행안되는 이슈 수정
class CtlMatchingBegin extends SuperController {
  final Rx<String> _sex = ''.obs;
  final _locations = [].obs;
  final RxList<String> _ageRange = ['14', '99'].obs;
  final _isStartAnimation = false.obs;
  AnimationController? _animationController;

  MatchingSignaling? _signaling;
  late RTCVideoRenderer localRenderer;
  final _inCalling = false.obs;
  Function()? openBottomSheet;

  get sex {
    return _sex;
  }

  get locations {
    return _locations;
  }

  get ageRange {
    return _ageRange;
  }

  get isStartAnimation {
    return _isStartAnimation;
  }

  get inCalling {
    return _inCalling;
  }

  get animationController {
    return _animationController;
  }

  void setAnimationController(AnimationController ctl) {
    _animationController = ctl;
  }

  void initRenderer() async {
    localRenderer = RTCVideoRenderer();
    await localRenderer.initialize();
  }

  startMatching() {
    off();
    Get.off(PageMatching(), arguments: {
      'sex': _sex.value,
      'locations': _locations.value,
      'ageRange': _ageRange.value
    });
  }

  Future<bool> isGrantedAllPermissions() async {
    // web은 실제로 사용할 때 권한 허용을 받을 수 있다.
    if (GetPlatform.isDesktop) return true;
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
    _locations.value =
        localStorage.storage.getStringList('matching.locations') ??
            [ConstantUser.locations[0].$2];
    _ageRange.value =
        localStorage.storage.getStringList('matching.ageRange') ?? ['14', '99'];
    _sex.value = localStorage.storage.getString('matching.sex') ??
        ConstantUser.sexOptions[0].$1;
  }

  void saveMatchingFilters(
      {String? sex, List<String>? locations, List<String>? ageRange}) {
    if (sex != null) {
      localStorage.storage.setString('matching.sex', sex);
      _sex.value = sex;
    }
    if (locations != null) {
      localStorage.storage.setStringList('matching.locations', locations);
      _locations.value = locations;
    }
    if (ageRange != null) {
      localStorage.storage.setStringList('matching.ageRange', ageRange);
      _ageRange.value = ageRange;
    }
  }

  void onVisible() async {
    if (GetPlatform.isMobile) {
      Wakelock.enable();
    }
    if (await isGrantedAllPermissions()) {
      initRenderer();
      _signaling = MatchingSignaling()
        ..connect()
        ..init()
        ..onLocalStream = ((stream) {
          localRenderer.srcObject = stream;
          localRenderer.muted = true;
          if (!_inCalling.value) {
            _inCalling.value = true;
            openBottomSheet?.call();
          }
        });
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
    off();
  }

  Future<void> off() async {
    try {
      if (GetPlatform.isMobile) {
        Wakelock.disable();
      }
      _signaling?.dispose();
      _signaling = null;
      _inCalling.value = false;
      _isStartAnimation.value = false;
      // localRenderer.srcObject = null;
      _animationController?.dispose();
      _animationController = null;
      return await localRenderer.dispose();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    print("dispose2");
    super.dispose();
    off();
  }

  @override
  void onDetached() {
    print("detached");
  }

  @override
  void onInactive() {
    print("inactive2");
  }

  @override
  void onPaused() {
    off();
    print("paused2");
  }

  @override
  void onResumed() async {
    print("resume2");
  }

  @override
  void onHidden() {
    print("hidden2");
  }
}
