import 'dart:convert';
import 'package:practical/src/constants/pref.constants.dart';
import 'package:practical/src/model/login.response.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wraps the [SharedPreferences].
class PrefUtils {
  late SharedPreferences _preferences;

  static PrefUtils? _instance;

  PrefUtils._() {
    initialize();
  }

  factory PrefUtils() {
    if (_instance == null) {
      _instance = PrefUtils._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String get prefix => "my_app";

  // Clear Preferences and DB for Logout time
  void clearPreferenceAndDB() async {
    _preferences.clear();
  }

  /// Gets the int value for the [key] if it exists.
  int getInt(String key, {int defaultValue = 0}) {
    try {
      return _preferences.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the bool value for the [key] if it exists.
  bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _preferences.getString(key)!.toLowerCase() == 'true';
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  String getString(String key, {String defaultValue = ""}) {
    try {
      return _preferences.getString(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  double getDouble(String key, {double defaultValue = 0.0}) {
    try {
      return _preferences.getDouble(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  List<String> getStringList(String key) {
    try {
      return _preferences.getStringList(key) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Gets the int value for the [key] if it exists.
  void saveInt(String key, int value) {
    _preferences.setInt(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  Future saveBoolean(String key, bool? value) {
    return _preferences.setString(key, value.toString());
  }

  /// Gets the int value for the [key] if it exists.
  void saveString(String key, String? value) {
    _preferences.setString(key, value ?? "");
  }

  /// Gets the int value for the [key] if it exists.
  void saveDouble(String key, double value) {
    _preferences.setDouble(key, value);
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  void saveStringList(String key, List<String> value) {
    _preferences.setStringList(key, value);
  }

  Future saveStringAsync(String s, String jsonEncode) async {
    await initialize();
    _preferences.setString(s, jsonEncode);
    print("-----------${_preferences.getString(s)}");
  }

  Future<String> getStringAsync(String s, {String defaultValue = ""}) async {
    try {
      await initialize();
      return _preferences.getString(s) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  UserData? getUserData() {
    var user = getString(keyUser);
    if (user.isNotEmpty) {
      return UserData.fromJson(jsonDecode(user));
    }
    return null;
  }

  void saveUser(UserData? userData) {
    saveString(keyUser, jsonEncode(userData!.toJson()));
  }
}
