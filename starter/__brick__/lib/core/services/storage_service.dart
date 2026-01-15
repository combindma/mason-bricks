import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferencesAsync _storage = SharedPreferencesAsync();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> save<T>(String key, T value) async{
    if (value is String) {
      await _storage.setString(key, value);
    } else if (value is bool) {
      await _storage.setBool(key, value);
    } else if (value is int) {
      await _storage.setInt(key, value);
    } else if (value is double) {
      await _storage.setDouble(key, value);
    } else if (value is List<String>) {
      await _storage.setStringList(key, value);
    } else {
      throw Exception("Type ${value.runtimeType} is not supported by SharedPreferences.");
    }
  }

  Future<void> saveObject(String key, Map<String, dynamic> jsonMap) async {
    String jsonString = jsonEncode(jsonMap);
    await _storage.setString(key, jsonString);
  }

  Future<String?> getString(String key) async {
    return await _storage.getString(key);
  }

  Future<bool?> getBool(String key) async {
    return await _storage.getBool(key);
  }

  Future<int?> getInt(String key) async {
    return await _storage.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    return await _storage.getDouble(key);
  }

  Future<List<String>?> getStringList(String key) async {
    return await _storage.getStringList(key);
  }

  Future<Map<String, dynamic>?> getObject(String key) async {
    String? jsonString = await _storage.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async {
    await _storage.clear();
  }

  Future<void> saveSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> saveCache<T>(String key, T value, [Duration expiration = const Duration(days: 30)]) async{
    final expiryData = {
      'value': value,
      'expiredAt': DateTime.now().add(expiration).toIso8601String(),
    };
    await saveObject(key, expiryData);
  }

  Future<T?> getCache<T>(String key) async{
    final data = await getObject(key);
    if (data == null) return null;

    final expiredAt = DateTime.parse(data['expiredAt']);
    if (DateTime.now().isAfter(expiredAt)) {
      _storage.remove(key);
      return null;
    }

    return data['value'];
  }
}