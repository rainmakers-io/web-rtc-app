import 'package:dio/dio.dart';

class ApiAuthService {
  late Dio api;

  ApiAuthService(Dio provider) {
    api = provider;
  }

  createAccount(Map<String, dynamic> body) async {
    Map<String, dynamic> data = {
      "purpose": body["purpose"] as String,
      "interests": body["interests"] as List<String>,
      "location": body["location"] as List<String>,
      "birth": body["birth"] as String,
      "gender": body["gender"] as String,
      "nickname": body["nickname"] as String,
    };

    var apiResponse =
        await api.post<Map<String, dynamic>>('/auth/onboard', data: data);
    Map<String, dynamic> result = {
      "statusCode": apiResponse.statusCode,
      "accessToken": apiResponse.data?['accessToken'] ?? '',
      "refreshToken": apiResponse.data?['refreshToken'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  login() async {
    var apiResponse = await api.post<Map<String, dynamic>>('/auth/signin');
    Map<String, dynamic> result = {
      "accessToken": apiResponse.data?['accessToken'] ?? '',
      "refreshToken": apiResponse.data?['refreshToken'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  renew() async {
    var apiResponse = await api.post<Map<String, dynamic>>('/auth/renew');
    Map<String, dynamic> result = {
      "accessToken": apiResponse.data?['accessToken'] ?? '',
      "refreshToken": apiResponse.data?['refreshToken'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }
}
