import 'dart:core';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';
import 'package:web_rtc_app/utils/MatchingSignaling.dart';
import 'package:permission_handler/permission_handler.dart';

late CtlMatchingRoom ctlMatchingRoom;

class CtlMatchingRoom extends SuperController {
  final Rx<String> _sex = ''.obs;

  MatchingSignaling? _signaling;
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  var inCalling = false.obs;
  var ableMatching = false.obs;

  get sex {
    return _sex;
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
    print("init");
  }

  @override
  void onReady() async {
    super.onReady();
    print("ready");
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
      print(e.toString());
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
