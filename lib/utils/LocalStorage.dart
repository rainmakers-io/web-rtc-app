import 'package:shared_preferences/shared_preferences.dart';

UtilLocalStorage localStorage = UtilLocalStorage();

class UtilLocalStorage {
  static final UtilLocalStorage _instance = UtilLocalStorage._();
  late SharedPreferences _storage;

  // constructor for private
  UtilLocalStorage._();

  factory UtilLocalStorage() {
    return _instance;
  }

  setInt(String key, int value) {
    SharedPreferences.getInstance().then((store) => store.setInt(key, value));
  }

  setBool(String key, bool value) {
    SharedPreferences.getInstance().then((store) => store.setBool(key, value));
  }

  setString(String key, String value) {
    SharedPreferences.getInstance()
        .then((store) => store.setString(key, value));
  }

  setStringList(String key, List<String> value) {
    SharedPreferences.getInstance()
        .then((store) => store.setStringList(key, value));
  }

  init() async {
    _storage = await SharedPreferences.getInstance();
  }
  SharedPreferences get storage {
    return _storage;
  }
}
