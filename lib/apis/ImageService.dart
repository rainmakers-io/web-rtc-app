import 'dart:io';

import 'package:get/get.dart';

class ApiImageService {
  late GetConnect _provider;

  ApiImageService(GetConnect provider) {
    _provider = provider;
  }

  addImages(Map<String, dynamic> body) async {
    var apiResponse = await _provider.post<Map<String, dynamic>>(
        '/images', body["images"] as List<File>);
    Map<String, dynamic> result = {
      "userId": apiResponse.body?['userId'] ?? '',
      "keys": apiResponse.body?['keys'] ?? [] as List<String>,
      "urls": apiResponse.body?['urls'] ?? [] as List<String>,
      "createdAt": apiResponse.body?['createdAt'] ?? '',
      "updatedAt": apiResponse.body?['updatedAt'] ?? '',
      "name": apiResponse.body?['name'] ?? '',
      "code": apiResponse.body?['code'] ?? -1,
      "message": apiResponse.body?['message'] ?? '',
      "error": apiResponse.body?['error'] ?? {},
    };
    return result;
  }

  myImages() async {
    var apiResponse = await _provider.get<Map<String, dynamic>>('/images/me');
    Map<String, dynamic> result = {
      "userId": apiResponse.body?['userId'] ?? '',
      "keys": apiResponse.body?['keys'] ?? [] as List<String>,
      "urls": apiResponse.body?['urls'] ?? [] as List<String>,
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
