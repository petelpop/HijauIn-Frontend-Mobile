import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/login.dart';

class SharedStorage {
  static const String _keyAccessToken = 'access_token';
  static const String _keyUserData = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static Future<void> saveLoginData(LoginData loginData) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_keyAccessToken, loginData.accessToken);
    
    await prefs.setString(_keyUserData, json.encode(loginData.user.toJson()));
    
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  static Future<UserData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_keyUserData);
    
    if (userDataString != null) {
      try {
        final userDataJson = json.decode(userDataString);
        return UserData.fromJson(userDataJson);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> updateUserData(UserData userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserData, json.encode(userData.toJson()));
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyUserData);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  static Future<Map<String, dynamic>?> getCompleteAuthData() async {
    final token = await getAccessToken();
    final userData = await getUserData();
    final isLoggedIn = await SharedStorage.isLoggedIn();

    if (token != null && userData != null && isLoggedIn) {
      return {
        'access_token': token,
        'user': userData,
        'is_logged_in': isLoggedIn,
      };
    }
    return null;
  }

  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
