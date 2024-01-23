import 'package:flutter_dotenv/flutter_dotenv.dart';

UtilConfig config = UtilConfig();

class UtilConfig {
  static final UtilConfig _instance = UtilConfig._();

  // constructor for private
  UtilConfig._();

  factory UtilConfig() {
    return _instance;
  }

  init() async {
    const cliEnvName = String.fromEnvironment('env', defaultValue: '.env');
    await dotenv.load(fileName: cliEnvName);
  }

  isWebDevMode() {
    return const String.fromEnvironment('web') == 'true';
  }

  String get(String envName) {
    String value = dotenv.env[envName] ?? '';
    if (value.isEmpty) {
      throw '존재하지 않는 env 값을 불러왔습니다: $envName';
    }
    return value;
  }
}
