// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

final sharedPreferences = SharedPreferences.getInstance();

class SharedPrefConfig {
  // Save bool data
  static Future<bool> saveBoolData(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBoolData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  // Save int data
  static Future<bool> saveIntData(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int> getIntData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? -1;
  }

  // Save double data
  static Future<bool> saveDoubleData(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double> getDoubleData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? -1;
  }

  // Save String data
  static Future<bool> saveStringData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> getStringData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  // Remove Data
  static Future<bool> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharePrefKeys.IS_REGISTERED, true);
    return prefs.clear();
  }
}
