import 'package:get/get.dart';
import 'package:web_rtc_app/apis/AuthService.dart';
import 'package:web_rtc_app/apis/HealthService.dart';
import 'package:web_rtc_app/apis/UserService.dart';
import 'package:web_rtc_app/utils/Config.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

ApiProvider apiProvider = ApiProvider();

class ApiProvider extends GetConnect {
  late ApiHealthService _healthService;
  late ApiAuthService _authService;
  late ApiUserService _userService;

  void initServices() {
    _healthService = ApiHealthService(this);
    _authService = ApiAuthService(this);
    _userService = ApiUserService(this);
  }

  ApiHealthService get healthService {
    return _healthService;
  }

  ApiAuthService get authService {
    return _authService;
  }

  ApiUserService get userService {
    return _userService;
  }

  void init() {
    httpClient.baseUrl = config.get('API_HOST');

    httpClient.addRequestModifier<Object?>((request) {
      String accessToken = localStorage.storage.getString('refreshToken') ?? '';
      if (accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
      // request.headers['Access-Control-Allow-Origin'] = '*';
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) {
      String refreshToken = response.body?['refreshToken'] ?? '';
      String accessToken = response.body?['accessToken'] ?? '';

      if (refreshToken.isNotEmpty) {
        localStorage.setString('refreshToken', refreshToken);
      }
      if (accessToken.isNotEmpty) {
        localStorage.setString('accessToken', accessToken);
      }

      return response;
    });

    // 401일 때 토큰을 갱신한다.
    httpClient.addAuthenticator<Object?>((request) async {
      String refreshToken =
          localStorage.storage.getString('refreshToken') ?? '';
      if (refreshToken.isNotEmpty) {
        try {
          var res = await _authService.renew();
          request.headers['Authorization'] = res['accessToken'];
          localStorage.setString('refreshToken', res['refreshToken']);
          localStorage.setString('accessToken', res['accessToken']);
        } catch (error) {
          // 로그인 페이지로 이동한다.
          // TODO: 로그인 토큰 만료 팝업 띄우기
          Get.toNamed('/guide');
        }
      }
      return request;
    });

    initServices();
  }
}
