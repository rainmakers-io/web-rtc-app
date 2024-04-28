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
import 'package:web_rtc_app/widgets/dialog/BottomSheetChooseTarget.dart';

late CtlMatchingBegin ctlMatchingBegin;

class CtlMatchingBegin extends SuperController {
  final Rx<String> _sex = ''.obs;
  final _locations = [].obs;
  final RxList<String> _ageRange = ['14', '99'].obs;
  final _isStartAnimation = false.obs;
  AnimationController? _animationController;

  final MatchingSignaling _signaling = MatchingSignaling();
  RTCVideoRenderer? localRenderer;
  final _inCalling = false.obs;

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

  initRenderer() {
    if (localRenderer == null) {
      localRenderer = RTCVideoRenderer();
      localRenderer?.initialize();
    }
  }

  startMatching() {
    off();
    Get.off(const PageMatching(), arguments: {
      'sex': _sex.value,
      'locations': _locations.value,
      'ageRange': _ageRange.value
    });
  }

  Future<bool> isGrantedAllPermissions() async {
    // web은 실제로 사용할 때 권한 허용을 받을 수 있다.
    if (GetPlatform.isDesktop) return true;
    bool isGranted = true;
    do {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.camera, Permission.microphone].request();
      statuses.forEach((key, permission) {
        if (permission.isDenied) {
          isGranted = false;
        }
      });
    } while (!isGranted);
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

  openBottomSheet() {
    DialogBottomSheetChooseTarget.show(
        sex: _sex.value,
        onPressedNext: (targetSex) {
          saveMatchingFilters(sex: targetSex);
        });
  }

  closeBottomSheet() {
    DialogBottomSheetChooseTarget.close();
  }

  void onVisible() async {
    if (GetPlatform.isMobile) {
      await Wakelock.enable();
    }

    if (await isGrantedAllPermissions()) {
      initRenderer();
      _signaling.init();
      _signaling.connect();
      animationController?.forward();
      if (!isStartAnimation.value) {
        openBottomSheet();
      }
      isStartAnimation.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _signaling.onLocalStream = ((stream) {
      localRenderer?.srcObject = stream;
      _inCalling.value = true;
    });
    initMatchingFilters();
    print("INIT2");
  }

  @override
  void onReady() {
    super.onReady();
    print("READY");
  }

  @override
  void onClose() {
    super.onClose();
    off();
    print("close");
  }

  Future<void> off() async {
    try {
      closeBottomSheet();
      if (GetPlatform.isMobile) {
        await Wakelock.disable();
      }
      _isStartAnimation.value = false;
      _animationController?.stop();
      await localRenderer?.dispose();
      localRenderer = null;
      _inCalling.value = false;
      _signaling.dispose();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    print("dispose2");
    off();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void onDetached() {
    print("detached");
  }

  @override
  void onInactive() {
    off();
    print("inactive2");
  }

  @override
  void onPaused() {
    print("paused2");
  }

  @override
  void onResumed() {
    onVisible();
    print("resume2");
  }

  @override
  void onHidden() {
    print("hidden2");
  }
}
