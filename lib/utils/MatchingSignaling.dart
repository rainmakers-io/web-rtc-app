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
    try {
      var stream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
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
    } catch (error) {
      rethrow;
    }
  }

  Future<bool?> switchCamera() async {
    var stream = localStream;
    if (stream != null) {
      return await Helper.switchCamera(stream.getTracks()[0]);
    }
    return null;
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
