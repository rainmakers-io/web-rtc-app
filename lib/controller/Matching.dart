import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/utils/Socket.dart';

late CtlMatching ctlMatching;

class CtlMatching extends SuperController {
  var partnerInfo = {}.obs;
  var isMatching = false.obs;
  Timer? timer;

  back() {
    closeSocket();
    Get.toNamed('/home');
  }

  closeMatchingResultModal() {
    partnerInfo.value = {};
  }

  initSocket() async {
    socket.init();
    socket.socketIo.onConnect((d) {
      startMatching();
    });
    socket.socketIo.on(ConstantUser.matchingEventsJson['INTRODUCE_EACH_USER']!,
        introduceEachUser);
    socket.socketIo
        .on(ConstantUser.matchingEventsJson['MATCH_RESULT']!, matchResult);
    socket.socketIo.on(
        ConstantUser.matchingEventsJson['RESTART_MATCHING_REQUEST']!,
        restartMatchingRequest);
    socket.socketIo.on(ConstantUser.matchingEventsJson['PARTNER_DISCONNECTED']!,
        partnerDisconnected);

    // webrtc 이벤트
    // _instance.on(ConstantUser.matchingEventsJson['START_WEBRTC_SIGNALING']!,
    //     handleStartWebrtcSignaling);
    // _instance.on(ConstantUser.matchingEventsJson['OFFER']!, handleOffer);
    // _instance.on(ConstantUser.matchingEventsJson['ANSWER']!, handleAnswer);
    // _instance.on(ConstantUser.matchingEventsJson['ICE']!, handleIceFromServer);
  }

  // 소개매칭 완료 이벤트 핸들러
  introduceEachUser(partnerUserInfo) {
    // TODO: 시간제한 30초
    if (partnerInfo.value.isEmpty) {
      partnerInfo.value = partnerUserInfo;
    }
  }

  startMatching() async {
    // 이미 매칭이 진행중이라면 시작하지 않는다.
    if (isMatching.value) return;
    isMatching.value = true;
    closeMatchingResultModal();
    var me = await apiProvider.userService.me();
    socket.socketIo.emit(ConstantUser.matchingEventsJson['START_MATCHING']!,
        {'userId': me['id']});
  }

  acceptMatch() async {
    if (!isMatching.value) return;
    isMatching.value = false;
    var me = await apiProvider.userService.me();
    socket.socketIo.emit(
        ConstantUser.matchingEventsJson['RESPOND_TO_INTRODUCE']!,
        {'userId': me['id'], 'response': 'accept'});
  }

  declineMatch() async {
    closeMatchingResultModal();
    isMatching.value = false;
    var me = await apiProvider.userService.me();
    socket.socketIo.emit(
        ConstantUser.matchingEventsJson['RESPOND_TO_INTRODUCE']!,
        {'userId': me['id'], 'response': 'decline'});
  }

  // 매칭 결과 이벤트 핸들러
  matchResult(data) async {
    closeMatchingResultModal();
    isMatching.value = false;
    if (data["result"]) {
      // 매칭이 성사된 경우의 처리
      if (data["initiator"]) {
        // socket.instance
        //     .emit(ConstantUser.matchingEventsJson['START_WEBRTC_SIGNALING']!);
      }
    } else {
      // 매칭이 성사되지 않은 경우의 처리
    }
  }

  restartMatchingRequest(data) {
    closeMatchingResultModal();
    isMatching.value = false;
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    int randomNum = Random().nextInt(10) + 5;
    timer = Timer(Duration(seconds: randomNum), () {
      startMatching();
    });
  }

  // 상대가 연결 해제됨을 알림 이벤트 핸들러
  partnerDisconnected(data) {
    closeMatchingResultModal();
    isMatching.value = false;
    startMatching();
  }

  closeSocket() {
    socket.socketIo.close();
    socket.socketIo.disconnect();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onDetached() {
    print("onDetached");
  }

  @override
  void onClose() {
    super.onClose();
    closeSocket();
    print("onClose");
  }

  @override
  void onHidden() {
    print("onHidden");
  }

  @override
  void onInactive() {
    print("onInactive");
    closeSocket();
  }

  @override
  void onPaused() {
    print("PAUSED");
  }

  @override
  void onResumed() {
    print("onResumed");
    initSocket();
  }
}
