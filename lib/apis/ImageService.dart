import 'package:dio/dio.dart';

class ApiImageService {
  late Dio api;

  ApiImageService(Dio provider) {
    api = provider;
  }

  addImages(List<String> body) async {
    // TODO: 웹에서는 다른 형태로 넣어야될듯...
    var data = FormData.fromMap({
      'images': body.map((path) {
        return MultipartFile.fromFileSync(path);
      }).toList()
    });

    var apiResponse =
        await api.post<Map<String, dynamic>>('/images', data: data);
    Map<String, dynamic> result = {
      "statusCode": apiResponse.statusCode,
      "userId": apiResponse.data?['userId'] ?? '',
      "keys": apiResponse.data?['keys'] ?? [] as List<String>,
      "urls": apiResponse.data?['urls'] ?? [] as List<String>,
      "createdAt": apiResponse.data?['createdAt'] ?? '',
      "updatedAt": apiResponse.data?['updatedAt'] ?? '',
      "name": apiResponse.data?['name'] ?? '',
      "code": apiResponse.data?['code'] ?? -1,
      "message": apiResponse.data?['message'] ?? '',
      "error": apiResponse.data?['error'] ?? {},
    };
    return result;
  }

  myImages() async {
    var apiResponse = await api.get<Map<String, dynamic>>('/images/me');
    Map<String, dynamic> result = {
      "userId": apiResponse.data?['userId'] ?? '',
      "keys": apiResponse.data?['keys'] ?? [] as List<String>,
      "urls": apiResponse.data?['urls'] ?? [] as List<String>,
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
