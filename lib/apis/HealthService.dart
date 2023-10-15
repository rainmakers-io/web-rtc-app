import 'package:get/get.dart';

class ApiHealthService {
  late GetConnect _provider;

  ApiHealthService(GetConnect provider) {
    _provider = provider;
  }

  checkHealth() {
    return _provider.get<Map<String, String>>('/health');
  }
}
