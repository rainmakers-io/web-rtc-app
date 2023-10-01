import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef void StreamStateCallback(MediaStream stream);

// WebRTC 커넥션 연결 헬퍼
class VideoChatSignaling {
  Map<String, dynamic> configuration = {};
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  StreamStateCallback? onAddRemoteStream;
  bool isEnabledAudio = true;
  bool isEnabledVideo = true;
  
  void toggleAudioTrack() {
    isEnabledAudio = !isEnabledAudio;
    if (localStream != null) {
      localStream!.getAudioTracks()[0].enabled = isEnabledAudio;
    }
  }

  void toggleVideoTrack() {
    isEnabledVideo = !isEnabledVideo;
    if (localStream != null) {
      localStream!.getVideoTracks()[0].enabled = isEnabledVideo;
    }
  }

  dispose() {
    localStream?.dispose();
    localStream = null;
    remoteStream?.dispose();
    remoteStream = null;
  }
}
