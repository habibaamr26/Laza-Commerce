import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Caching {
  static late final SharedPreferences _preferences;
  static final storage = FlutterSecureStorage();
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, required dynamic value}) {
    if (value is String) {
      return _preferences.setString(key, value);
    } else if (value is int) {
      return _preferences.setInt(key, value);
    } else if (value is bool) {
      return _preferences.setBool(key, value);
    } else if (value is double) {
      return _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value);
    } else {
      return Future.value(false); // unsupported type
    }
  }

  static String? getString({required String key}) {
    return _preferences.getString(key);
  }

  static int? getInt({required String key}) {
    return _preferences.getInt(key);
  }

  static bool? getBool({required String key}) {
    return _preferences.getBool(key);
  }

  static double? getDouble({required String key}) {
    return _preferences.getDouble(key);
  }

  static List<String>? getStringList({required String key}) {
    return _preferences.getStringList(key);
  }

  static Future<bool> remove({required String key}) {
    return _preferences.remove(key);
  }

  static Future<bool> clearAll() {
    return _preferences.clear();
  }

  static Future<void> setSecureStorage({
    required String key,
    required String value,
  }) {
    return storage.write(key: key, value: value);
  }

  static Future<String?> getSecureStorage({required String key}) {
    return storage.read(key: key);
  }

  static Future<void> deleteSecureStorage({required String key}) {
    return storage.delete(key: key);
  }

  static Future<void> deleteAllSecureStorage() {
    return storage.deleteAll();
  }
}
