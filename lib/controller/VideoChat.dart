import 'dart:async';
import 'dart:core';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/utils/Socket.dart';
import 'package:web_rtc_app/utils/VideoChatSignaling.dart';

late CtlVideoChat ctlVideoChat;

class CtlVideoChat extends SuperController {
  late RTCVideoRenderer localRenderer;
  late RTCVideoRenderer remoteRenderer;
  late VideoChatSignaling? _signaling;
  final _isOnLocalRenderer = false.obs;
  final _isOnRemoteRenderer = false.obs;
  final _partnerInfo = {
    'nickname': '',
    'age': 0,
    'gender': 'ALL',
    'location': [''],
    'interests': [''],
    'purpose': '',
    'images': [''],
  }.obs;
  var roomName = '';

  get isOnLocalRenderer {
    return _isOnLocalRenderer;
  }

  get isOnRemoteRenderer {
    return _isOnRemoteRenderer;
  }

  get partnerInfo {
    return _partnerInfo;
  }

  void initRenderer() async {
    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

// TODO: 상대방 종료시 예외처리 구현하기
  void initSocket() {
    if (socket.socketIo.connected) {
      // webrtc 이벤트
      socket.socketIo.on(
          ConstantUser.matchingEventsJson['START_WEBRTC_SIGNALING']!,
          createRoom);
      socket.socketIo.on(ConstantUser.matchingEventsJson['OFFER']!, joinRoom);
      socket.socketIo.on(
          ConstantUser.matchingEventsJson['ANSWER']!, someoneTryingJoinRoom);
      socket.socketIo.on(ConstantUser.matchingEventsJson['ICE']!, roomUpdated);
    }
    // 이전 페이지에서 소켓이 초기화되지 않고 접근됨 매칭 페이지로 보내기
  }

  void onVisible() async {
    if (GetPlatform.isMobile) {
      Wakelock.enable();
    }
    if (await isGrantedAllPermissions()) {
      initRenderer();
      initSocket();
      _signaling = VideoChatSignaling();
      _signaling?.onIceCandidate = ((candidate) {
        print("EMIT ICE");
        socket.socketIo.emit(ConstantUser.matchingEventsJson['ICE']!,
            {'ice': candidate, 'roomName': roomName});
      });
      _signaling?.onLocalStream = ((stream) {
        localRenderer.srcObject = stream;
        localRenderer.muted = true;
        _isOnLocalRenderer.value = true;
      });
      _signaling?.onRemoteStream = ((stream) {
        remoteRenderer.srcObject = stream;
        _isOnRemoteRenderer.value = true;
      });
      await _signaling?.connect();
      await _signaling?.init();

      var initiator = Get.arguments['initiator'];
      var partnerId = Get.arguments['partnerId'];
      if (partnerId != null) {
        var data = await apiProvider.userService.getUserById(partnerId);
        var images = await apiProvider.imageService.getImagesById(partnerId);
        _partnerInfo.value['userId'] = partnerId;
        _partnerInfo.value['nickname'] = data['nickname'];
        _partnerInfo.value['age'] = data['age'];
        _partnerInfo.value['gender'] = data['gender'];
        _partnerInfo.value['location'] = data['location'];
        _partnerInfo.value['purpose'] = data['purpose'];
        _partnerInfo.value['interests'] = data['interests'];
        _partnerInfo.value['images'] = images['urls'];
      }

      if (initiator) {
        // 상대방이 렌더링 되기까지 잠깐 기다린다.
        // 추후 방 입장 완료되었다는 이벤트 추가되면 좋을듯
        Timer(const Duration(seconds: 3), () {
          print('initiator $initiator');
          socket.socketIo
              .emit(ConstantUser.matchingEventsJson['START_WEBRTC_SIGNALING']!);
        });
      }
    }
  }

  void createRoom(data) async {
    print("CREATE");
    var offer = await _signaling?.createOffer();
    roomName = data['roomName'];
    socket.socketIo.emit(ConstantUser.matchingEventsJson['OFFER']!, {
      'offer': {'sdp': offer?.sdp, 'type': offer?.type},
      'roomName': data['roomName']
    });
  }

  void joinRoom(data) async {
    print("JOIN");
    var answer = await _signaling?.createAnswer(data['offer']);
    // roomName = data['roomName'];
    socket.socketIo.emit(ConstantUser.matchingEventsJson['ANSWER']!, {
      'answer': {'sdp': answer?.sdp, 'type': answer?.type}
    });
  }

  void someoneTryingJoinRoom(data) {
    print("TRYING");
    _signaling?.setAnswer(data);
  }

  void roomUpdated(data) {
    print("ROOMUPDATE ICE");
    _signaling?.setIce(data);
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

  void off() {
    try {
      print("OFF");
      _signaling?.dispose();
      _signaling = null;
      _isOnLocalRenderer.value = false;
      _isOnRemoteRenderer.value = false;
      localRenderer.dispose();
      remoteRenderer.dispose();
      localRenderer.srcObject = null;
      remoteRenderer.srcObject = null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    off();
    super.onClose();
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
