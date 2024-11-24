import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  static final SharedHandler _instance = SharedHandler._internal();
  SharedPreferences? _prefs;

  factory SharedHandler() {
    return _instance;
  }

  SharedHandler._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    }
  }

  dynamic readData(String key) {
    return _prefs?.get(key);
  }

  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}
