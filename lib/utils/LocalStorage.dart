import 'package:shared_preferences/shared_preferences.dart';

class UtilLocalStorage {
  static final UtilLocalStorage _instance = UtilLocalStorage._();
  late SharedPreferences _storage;

  // constructor for private
  UtilLocalStorage._() {
    init();
  }

  factory UtilLocalStorage() {
    return _instance;
  }

  init() async {
    _storage = await SharedPreferences.getInstance();
  }

  SharedPreferences get storage {
    return _storage;
  }
}
