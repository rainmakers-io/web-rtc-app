import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';
import 'package:web_rtc_app/utils/MatchingSignaling.dart';
import 'package:permission_handler/permission_handler.dart';

late CtlMatchingRoom ctlMatchingRoom;

class CtlMatchingRoom extends SuperController {
  final MatchingSignaling _signaling = MatchingSignaling();
  RTCVideoRenderer localRenderer = RTCVideoRenderer();

  void initRenderer() {
    localRenderer.initialize();
  }

  void connectSignaling() {
    _signaling?.onLocalStream = ((stream) {
      localRenderer.srcObject = stream;
      update();
    });
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
      connectSignaling();
      initRenderer();
      await _signaling.connect();
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
    _signaling.dispose();
    localRenderer.dispose();
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
