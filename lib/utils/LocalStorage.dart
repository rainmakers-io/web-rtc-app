import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();
  late SharedPreferences _storage;

  // constructor for private
  LocalStorage._() {
    init();
  }

  factory LocalStorage() {
    return _instance;
  }

  init() async {
    _storage = await SharedPreferences.getInstance();
  }

  SharedPreferences get storage {
    return _storage;
  }
}
