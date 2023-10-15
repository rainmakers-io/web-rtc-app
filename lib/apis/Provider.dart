import 'package:get/get.dart';
import 'package:web_rtc_app/apis/HealthService.dart';
import 'package:web_rtc_app/utils/Config.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

ApiProvider apiProvider = ApiProvider();

class ApiProvider extends GetConnect {
  late ApiHealthService _healthService;

  void initServices() {
    _healthService = ApiHealthService(this);
  }

  ApiHealthService get healthService {
    return _healthService;
  }

  void init() {
    httpClient.baseUrl = config.get('API_HOST');

    httpClient.addRequestModifier<Object?>((request) {
      String accessToken = localStorage.storage.getString('refreshToken') ?? '';
      if (accessToken.isNotEmpty) {
        request.headers['Authorization'] = accessToken;
      }
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
          var res = await post('/api/auth/renew', {refreshToken});
          String newRefreshToken = res.body['refreshToken'] ?? '';
          String newAccessToken = res.body['accessToken'] ?? '';
          request.headers['Authorization'] = newAccessToken;
          localStorage.setString('refreshToken', newRefreshToken);
          localStorage.setString('accessToken', newAccessToken);
        } catch (error) {
          // 로그인 페이지로 이동한다.
          // TODO: 로그인 토큰 만료 팝업 띄우기
          Get.toNamed('/');
        }
      }
      return request;
    });

    initServices();
  }
}
