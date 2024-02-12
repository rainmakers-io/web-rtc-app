import 'package:dio/dio.dart';

class ApiBlockLogService {
  late Dio api;

  ApiBlockLogService(Dio provider) {
    api = provider;
  }

  blockUser(Map<String, dynamic> body) async {
    Map<String, dynamic> data = {
      "userId": body["userId"] as String,
      "targetId": body["userId"] as String,
    };

    var apiResponse =
        await api.put<Map<String, dynamic>>('/blockLog/block', data: data);

    Map<String, dynamic> result = {
      "userId": apiResponse.data?['userId'] ?? '',
      "blockUserIds": apiResponse.data?['blockUserIds'] ?? [],
      "name": apiResponse.data?['name'] ?? '',
      "createdAt": apiResponse.data?['name'] ?? '',
      "updatedAt": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  unblockUser(Map<String, dynamic> body) async {
    Map<String, dynamic> data = {
      "userId": body["userId"] as String,
      "targetId": body["userId"] as String,
    };

    var apiResponse =
        await api.put<Map<String, dynamic>>('/blockLog/unblock', data: data);

    Map<String, dynamic> result = {
      "userId": apiResponse.data?['userId'] ?? '',
      "blockUserIds": apiResponse.data?['blockUserIds'] ?? [],
      "name": apiResponse.data?['name'] ?? '',
      "createdAt": apiResponse.data?['name'] ?? '',
      "updatedAt": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  myBlockLogs() async {
    var apiResponse = await api.get<Map<String, dynamic>>('/blockLog/me');

    Map<String, dynamic> result = {
      "userId": apiResponse.data?['userId'] ?? '',
      "blockUserIds": apiResponse.data?['blockUserIds'] ?? [],
      "name": apiResponse.data?['name'] ?? '',
      "createdAt": apiResponse.data?['name'] ?? '',
      "updatedAt": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }
}
