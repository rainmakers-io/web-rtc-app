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
  Null Function(dynamic)? partnerDisconnected;
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
      socket.socketIo
          .off(ConstantUser.matchingEventsJson['PARTNER_DISCONNECTED']!);
      socket.socketIo.on(
          ConstantUser.matchingEventsJson['PARTNER_DISCONNECTED']!,
          partnerDisconnected!.call);
    }
    // 이전 페이지에서 소켓이 초기화되지 않고 접근됨 매칭 페이지로 보내기
  }

  void onVisible() async {
    if (GetPlatform.isMobile) {
      Wakelock.enable();
    }
    if (await isGrantedAllPermissions()) {
      initRenderer();
      _signaling = VideoChatSignaling();
      _signaling?.onIceCandidate = ((candidate) {
        print("EMIT ICE");
        socket.socketIo.emit(ConstantUser.matchingEventsJson['ICE']!,
            {'ice': candidate, 'roomName': roomName});
      });
      _signaling?.onLocalStream = ((stream) {
        localRenderer.srcObject = stream;
        _isOnLocalRenderer.value = true;
      });
      _signaling?.onRemoteStream = ((stream) async {
        remoteRenderer.srcObject = stream;
        _isOnRemoteRenderer.value = true;
        // Helper.selectAudioOutput(audios[0].deviceId);
        Helper.setSpeakerphoneOn(true);
      });
      await _signaling?.connect();
      await _signaling?.init();
      initSocket();

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

  closeSocket() {
    socket.socketIo.close();
    socket.socketIo.disconnect();
  }

  void off() {
    // 이미 종료됐다면 무시
    if (_signaling == null ||
        _isOnLocalRenderer.value == false ||
        _isOnRemoteRenderer.value == false) return;
    try {
      print("OFF VIDEOCHAT");
      _signaling?.dispose();
      _signaling = null;
      _isOnLocalRenderer.value = false;
      _isOnRemoteRenderer.value = false;
      localRenderer.dispose();
      remoteRenderer.dispose();
      closeSocket();
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
    super.onClose();
    off();
    print("close3");
  }

  @override
  void onDetached() {
    print("detached3");
  }

  @override
  void onInactive() {
    print("inactive3");
  }

  @override
  void onPaused() {
    print("paused3");
  }

  @override
  void onResumed() async {
    print("resume3");
  }

  @override
  void onHidden() {
    print("hidden3");
  }
}
