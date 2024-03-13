import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get_utils/get_utils.dart';

typedef void StreamStateCallback(MediaStream stream);

// TODO: matchingSignaling이랑 합치기
enum SignalingStatus {
  SocketConnect,
  SocketClosed,
  SocketError,
}

// WebRTC 커넥션 연결 헬퍼
class VideoChatSignaling {
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  bool isEnabledAudio = true;
  bool isEnabledVideo = true;
  List<MediaDeviceInfo>? _mediaDevicesList;
  StreamStateCallback? onRemoteStream;
  StreamStateCallback? onLocalStream;
  Function(SignalingStatus state)? onSignalingStateChange;
  Function(Map<String, dynamic> candidate)? onIceCandidate;

  init() async {
    navigator.mediaDevices.ondevicechange = (event) async {
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    };
    peerConnection = await createPeerConnection(configuration);
    registerStatusListeners();
    // 1. media 정보 peerConnection에 셋팅
    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });
    peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      print('Got candidate: ${candidate}');
      onIceCandidate?.call({
        'candidate': candidate.candidate,
        'sdpMLineIndex': candidate.sdpMLineIndex,
        'sdpMid': candidate.sdpMid
      });
    };
    peerConnection?.onTrack = (RTCTrackEvent event) {
      print('Got remote track: ${event.streams[0]}');
      event.streams[0].getTracks().forEach((track) {
        print('Add a track to the remoteStream: $track');
        remoteStream?.addTrack(track);
      });
    };
    print('INIT');
  }

  connect() async {
    try {
      var stream = await navigator.mediaDevices.getUserMedia({
        'audio': true,
        'video': {
          'facingMode': 'user',
          'mandatory': {
            'minWidth':
                '640', // Provide your own width, height and frame rate here
            'minHeight': '480',
            'minFrameRate': '30',
          }
        }
      });

      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
      localStream = stream;
      onLocalStream?.call(stream);
      print("CONNECT");
    } catch (error) {
      rethrow;
    }
  }

  Future<RTCSessionDescription> createOffer() async {
    // 2. Offer(SDP)정보 서버에 전송
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    return offer;
  }

  Future<RTCSessionDescription> createAnswer(Map<String, dynamic> offer) async {
    // 2. SDP(Offer)정보 셋팅
    await peerConnection?.setRemoteDescription(
      RTCSessionDescription(offer['sdp'], offer['type']),
    );
    // 3. SDP(Answer)정보 보내기
    var answer = await peerConnection!.createAnswer();
    print('Created Answer $answer');
    await peerConnection!.setLocalDescription(answer);
    return answer;
  }

  setAnswer(Map<String, dynamic> data) async {
    print("Someone tried to connect");
    print(data);
    // answer을 통해 web rtc 정보를 얻어온다.
    var answer =
        RTCSessionDescription(data['answer']['sdp'], data['answer']['type']);
    // 이제 remote와 연결한다.
    await peerConnection?.setRemoteDescription(answer);
  }

  setIce(Map<String, dynamic> data) {
    print("ICE");
    print(data);
    peerConnection?.addCandidate(
      RTCIceCandidate(
        data['ice']['candidate'],
        data['ice']['sdpMid'],
        data['ice']['sdpMLineIndex'],
      ),
    );
  }

  void registerStatusListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      onRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }

  void toggleAudioTrack() {
    isEnabledAudio = !isEnabledAudio;
    if (localStream != null) {
      localStream!.getAudioTracks()[0].enabled = isEnabledAudio;
    }
  }

  void enableSpeakerphone() {
    if (localStream != null) {
      localStream!.getAudioTracks()[0].enableSpeakerphone(true);
    }
  }

  void toggleVideoTrack() {
    isEnabledVideo = !isEnabledVideo;
    if (localStream != null) {
      localStream!.getVideoTracks()[0].enabled = isEnabledVideo;
    }
  }

  dispose() {
    if (GetPlatform.isWeb) {
      localStream?.getTracks().forEach((track) => track.stop());
      remoteStream?.getTracks().forEach((track) => track.stop());
    }
    peerConnection?.dispose();
    localStream?.dispose();
    localStream = null;
    remoteStream?.dispose();
    remoteStream = null;
  }
}
