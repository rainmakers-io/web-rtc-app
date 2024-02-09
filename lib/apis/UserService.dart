import 'package:dio/dio.dart';

class ApiUserService {
  late Dio api;

  ApiUserService(Dio provider) {
    api = provider;
  }

  me() async {
    var apiResponse = await api.get<Map<String, dynamic>>('/users/me');
    Map<String, dynamic> result = {
      "id": apiResponse.data?['id'] ?? '',
      "socketId": apiResponse.data?['socketId'] ?? '',
      "gender": apiResponse.data?['gender'] ?? '',
      "nickname": apiResponse.data?['nickname'] ?? '',
      "location": apiResponse.data?['location'] ?? '',
      "purpose": apiResponse.data?['purpose'] ?? '',
      "interests": apiResponse.data?['interests'] ?? [] as List<String>,
      "bans": apiResponse.data?['bans'] ?? [] as List<String>,
      "reported": apiResponse.data?['reported'] ?? -1,
      "createdAt": apiResponse.data?['createdAt'] ?? '',
      "updatedAt": apiResponse.data?['updatedAt'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  getUserById(String id) async {
    var apiResponse = await api.get<Map<String, dynamic>>('/users/$id');
    Map<String, dynamic> result = {
      "id": apiResponse.data?['id'] ?? '',
      "socketId": apiResponse.data?['socketId'] ?? '',
      "gender": apiResponse.data?['gender'] ?? '',
      "nickname": apiResponse.data?['nickname'] ?? '',
      "location": apiResponse.data?['location'] ?? '',
      "purpose": apiResponse.data?['purpose'] ?? '',
      "interests": apiResponse.data?['interests'] ?? [] as List<String>,
      "bans": apiResponse.data?['bans'] ?? [] as List<String>,
      "reported": apiResponse.data?['reported'] ?? -1,
      "createdAt": apiResponse.data?['createdAt'] ?? '',
      "updatedAt": apiResponse.data?['updatedAt'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }
}
