import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _isLoggedInKey = 'isLoggedIn';

  // Getter to check if the user is logged in
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Setter to save the login status
  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Clear the login status (logout)
  static Future<void> clearLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }
}
