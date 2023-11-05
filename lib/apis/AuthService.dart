import 'package:get/get.dart';

class ApiAuthService {
  late GetConnect _provider;

  ApiAuthService(GetConnect provider) {
    _provider = provider;
  }

  createAccount(Map<String, dynamic> body) async {
    Map<String, dynamic> data = {
      "purpose": body["purpose"] as String,
      "interests": body["interests"] as List<String>,
      "location": body["location"] as String,
      "birth": body["birth"] as String,
      "gender": body["gender"] as String,
      "nickname": body["nickname"] as String,
    };

    var apiResponse =
        await _provider.post<Map<String, dynamic>>('/auth/onboard', data);
    Map<String, dynamic> result = {
      "accessToken": apiResponse.body?['accessToken'] ?? '',
      "refreshToken": apiResponse.body?['refreshToken'] ?? '',
      "name": apiResponse.body?['name'] ?? '',
      "code": apiResponse.body?['code'] ?? -1,
      "message": apiResponse.body?['message'] ?? '',
      "error": apiResponse.body?['error'] ?? {},
    };
    return result;
  }

  login() async {
    var apiResponse =
        await _provider.post<Map<String, dynamic>>('/auth/signin', {});
    Map<String, dynamic> result = {
      "accessToken": apiResponse.body?['accessToken'] ?? '',
      "refreshToken": apiResponse.body?['refreshToken'] ?? '',
      "name": apiResponse.body?['name'] ?? '',
      "code": apiResponse.body?['code'] ?? -1,
      "message": apiResponse.body?['message'] ?? '',
      "error": apiResponse.body?['error'] ?? {},
    };
    return result;
  }

  renew() async {
    var apiResponse =
        await _provider.post<Map<String, dynamic>>('/auth/renew', {});
    Map<String, dynamic> result = {
      "accessToken": apiResponse.body?['accessToken'] ?? '',
      "refreshToken": apiResponse.body?['refreshToken'] ?? '',
      "name": apiResponse.body?['name'] ?? '',
      "code": apiResponse.body?['code'] ?? -1,
      "message": apiResponse.body?['message'] ?? '',
      "error": apiResponse.body?['error'] ?? {},
    };
    return result;
  }
}
