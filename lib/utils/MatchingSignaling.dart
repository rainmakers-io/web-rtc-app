import 'package:flutter_webrtc/flutter_webrtc.dart';

class MatchingSignaling {
  Map<String, dynamic> configuration = {};
  MediaStream? localStream;

  Function(MediaStream stream)? onLocalStream;

  connect() async {
    // TODO: id를 가져와서 방 연결
    try {
      var stream = await navigator.mediaDevices
          .getUserMedia({'video': true, 'audio': true});
      onLocalStream?.call(stream);
      localStream = stream;
    } catch (error) {
      print(error);
    }
  }

  dispose() {
    localStream?.dispose();
    localStream = null;
  }
}
