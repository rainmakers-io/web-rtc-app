import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_rtc_app/utils/Config.dart';

UtilSocket socket = UtilSocket();

class UtilSocket {
  late Socket socketIo;
  static final UtilSocket _instance = UtilSocket._();

  // constructor for private
  UtilSocket._();

  factory UtilSocket() {
    return _instance;
  }

  init() {
    socketIo = io(config.get('API_HOST'),
        OptionBuilder().setTransports(['websocket']).build());

    socketIo.nsp = '/';
    // 인터넷 환경 및 서버쪽 middleware의 거부로 발생
    socketIo.onConnectError((data) {
      print('ConnectError: $data');
      socketIo.close();
    });
    socketIo.onDisconnect((data) {
      print('Disconnect: $data');
      socketIo.close();
    });
    socketIo.onConnect((data) {
      print('Connect: $data');
    });
    socketIo.onAny((event, data) => print('ANY: $event, $data'));
  }

  dispose() {
    socketIo.dispose();
  }
}
