import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/pages/VideoChat.dart';
import 'package:web_rtc_app/utils/Socket.dart';

late CtlMatching ctlMatching;

// TODO
// 매칭 중 나갈시 다시 매칭 안됨
// 신고하기 기능

//mypage - 권한 필요 설명
//서비스 정책 설명
//개인정보 수정(재가입)
//모바일, 모바일 테스트
// 디자인 체크
// 리팩토링 및 버그 수정
class CtlMatching extends SuperController {
  final _partnerInfo = {}.obs;
  var isMatching = false.obs;
  var me = {};
  Timer? timer;
  Function(dynamic info)? openBottomSheet;
  Function? closeBottomSheet;

  get partnerInfo {
    return _partnerInfo;
  }

  back() {
    closeSocket();
    Get.toNamed('/home');
  }

  closeMatchingResultModal() {
    _partnerInfo.value = {};
    closeBottomSheet?.call();
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
  }

  // 소개매칭 완료 이벤트 핸들러
  introduceEachUser(partnerUserInfo) {
    // TODO: 시간제한 30초
    print('PARTNER $partnerUserInfo');
    _partnerInfo.value = partnerUserInfo;
    openBottomSheet?.call(partnerUserInfo);
  }

  startMatching() async {
    isMatching.value = true;
    var locations = Get.arguments['locations'];
    var ageRange = Get.arguments["ageRange"];
    var sex = Get.arguments['sex'];
    me = await apiProvider.userService.me();
    socket.socketIo.emit(ConstantUser.matchingEventsJson['START_MATCHING']!, {
      'userId': me['id'],
      'filter': {
        'gender': sex,
        'location': locations[0],
        'minAge': ageRange[0],
        'maxAge': ageRange[1],
      }
    });
  }

  acceptMatch() async {
    if (!isMatching.value) return;
    isMatching.value = false;
    socket.socketIo.emit(
        ConstantUser.matchingEventsJson['RESPOND_TO_INTRODUCE']!,
        {'userId': me['id'], 'response': 'accept'});
  }

  declineMatch() async {
    isMatching.value = false;
    socket.socketIo.emit(
        ConstantUser.matchingEventsJson['RESPOND_TO_INTRODUCE']!,
        {'userId': me['id'], 'response': 'decline'});
  }

  // 매칭 결과 이벤트 핸들러
  matchResult(data) async {
    isMatching.value = false;
    var partnerId = _partnerInfo.value['id'];
    if (data["result"]) {
      // 매칭이 성사된 경우
      Get.offAll(PageVideoChat(), arguments: {
        'initiator': data["initiator"],
        'partnerId': partnerId,
      });
    } else {
      closeMatchingResultModal();
    }
  }

  restartMatchingRequest(data) {
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
    print("onClose");
  }

  @override
  void onHidden() {
    print("onHidden");
    closeSocket();
  }

  @override
  void onInactive() {
    print("onInactive");
  }

  @override
  void onPaused() {
    print("PAUSED");
  }

  @override
  void onResumed() {
    print("onResumed");
    Get.offAllNamed('/home');
  }
}
