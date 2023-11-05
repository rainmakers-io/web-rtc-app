import 'package:get/get.dart';

class ApiUserService {
  late GetConnect _provider;

  ApiUserService(GetConnect provider) {
    _provider = provider;
  }

  me() async {
    var apiResponse = await _provider.get<Map<String, dynamic>>('/users/me');
    Map<String, dynamic> result = {
      "id": apiResponse.body?['id'] ?? '',
      "socketId": apiResponse.body?['socketId'] ?? '',
      "gender": apiResponse.body?['gender'] ?? '',
      "nickname": apiResponse.body?['nickname'] ?? '',
      "location": apiResponse.body?['location'] ?? '',
      "purpose": apiResponse.body?['purpose'] ?? '',
      "interests": apiResponse.body?['interests'] ?? [] as List<String>,
      "bans": apiResponse.body?['bans'] ?? [] as List<String>,
      "reported": apiResponse.body?['reported'] ?? -1,
      "createdAt": apiResponse.body?['createdAt'] ?? '',
      "updatedAt": apiResponse.body?['updatedAt'] ?? '',
      "name": apiResponse.body?['name'] ?? '',
      "code": apiResponse.body?['code'] ?? -1,
      "message": apiResponse.body?['message'] ?? '',
      "error": apiResponse.body?['error'] ?? {},
    };
    return result;
  }
}
