import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/apis/AuthService.dart';
import 'package:web_rtc_app/apis/BlockLogService.dart';
import 'package:web_rtc_app/apis/HealthService.dart';
import 'package:web_rtc_app/apis/ImageService.dart';
import 'package:web_rtc_app/apis/UserService.dart';
import 'package:web_rtc_app/utils/Config.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

ApiProvider apiProvider = ApiProvider();

class ApiProvider {
  final dio = Dio();
  late ApiHealthService _healthService;
  late ApiAuthService _authService;
  late ApiUserService _userService;
  late ApiImageService _imageService;
  late ApiBlockLogService _blockLogService;

  void initServices() {
    _healthService = ApiHealthService(dio);
    _authService = ApiAuthService(dio);
    _userService = ApiUserService(dio);
    _imageService = ApiImageService(dio);
    _blockLogService = ApiBlockLogService(dio);
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

  ApiImageService get imageService {
    return _imageService;
  }

  ApiBlockLogService get blockLogService {
    return _blockLogService;
  }

  void init() {
    dio.options.baseUrl = config.get('API_HOST');
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      String accessToken = localStorage.storage.getString('refreshToken') ?? '';
      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      // options.headers['Access-Control-Allow-Origin'] = '*';
      return handler.next(options);
    }, onResponse: (response, handler) {
      String refreshToken = response.data?['refreshToken'] ?? '';
      String accessToken = response.data?['accessToken'] ?? '';

      if (refreshToken.isNotEmpty) {
        localStorage.setString('refreshToken', refreshToken);
      }
      if (accessToken.isNotEmpty) {
        localStorage.setString('accessToken', accessToken);
      }

      return handler.next(response);
      // 401일 때 토큰을 갱신한다.
    }, onError: (e, handler) async {
      String refreshToken =
          localStorage.storage.getString('refreshToken') ?? '';
      if (refreshToken.isNotEmpty && e.response?.statusCode == 401) {
        try {
          var res = await _authService.renew();
          e.response?.headers.set('Authorization', res['accessToken']);
          localStorage.setString('refreshToken', res['refreshToken']);
          localStorage.setString('accessToken', res['accessToken']);
        } catch (error) {
          // 로그인 페이지로 이동한다.
          Get.offAllNamed('/login');
        }
      } else if (e.response?.statusCode == 401) {
        Get.offAllNamed('/login');
      }
      return handler.next(e);
    }));

    initServices();
  }
}
