import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _token = "x-token";

  //---------------------------------------------------
  static Future<bool> setToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (token.isEmpty && token != '') {
      return _prefs.setString(_token, token);
    } else {
      return _prefs.remove(_token);
    }
  }

  static Future<String> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      return _prefs.getString(_token) ?? "";
    } catch (_) {
      return '';
    }
  }

  static Future<bool> clearToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      _prefs.clear();
      return true;
    } catch (_) {
      return false;
    }
  }
}
