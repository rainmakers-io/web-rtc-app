import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get_utils/get_utils.dart';

enum SignalingStatus {
  SocketConnect,
  SocketClosed,
  SocketError,
}

class MatchingSignaling {
  Map<String, dynamic> configuration = {};
  MediaStream? localStream;
  List<MediaDeviceInfo>? _mediaDevicesList;

  Function(MediaStream stream)? onLocalStream;
  Function(SignalingStatus state)? onSignalingStateChange;

  init() {
    navigator.mediaDevices.ondevicechange = (event) async {
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    };
  }

  connect() async {
    // TODO: id를 가져와서 방 연결
    try {
      var stream = await navigator.mediaDevices.getUserMedia({
        'audio': true,
        'video': {
          'mandatory': {
            'minWidth':
                '640', // Provide your own width, height and frame rate here
            'minHeight': '480',
            'minFrameRate': '30',
          },
        }
      });

      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
      localStream = stream;
      onLocalStream?.call(stream);
    } catch (error) {
      print(error);
    }
  }

  dispose() {
    if (GetPlatform.isWeb) {
      localStream?.getTracks().forEach((track) => track.stop());
    }
    navigator.mediaDevices.ondevicechange = null;
    localStream?.dispose();
    localStream = null;
  }
}
