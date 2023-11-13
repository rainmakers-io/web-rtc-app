import 'package:dio/dio.dart';

class ApiHealthService {
  late Dio api;

  ApiHealthService(Dio provider) {
    api = provider;
  }

  Future<Response> checkHealth() {
    return api.get<Map<String, String>>('/health');
  }
}
