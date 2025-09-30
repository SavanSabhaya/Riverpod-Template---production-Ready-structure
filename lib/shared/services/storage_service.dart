import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class StorageService {
  static const String _userBoxName = 'user_box';
  static const String _cacheBoxName = 'cache_box';
  static const String _settingsBoxName = 'settings_box';

  late Box<User> _userBox;
  late Box<dynamic> _cacheBox;
  late Box<dynamic> _settingsBox;
  late SharedPreferences _prefs;

  // Initialize storage
  Future<void> init() async {
    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();

    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register adapters
    Hive.registerAdapter(UserAdapter());

    // Open boxes
    _userBox = await Hive.openBox<User>(_userBoxName);
    _cacheBox = await Hive.openBox(_cacheBoxName);
    _settingsBox = await Hive.openBox(_settingsBoxName);
  }

  // User Storage Methods
  Future<void> saveUser(User user) async {
    await _userBox.put('current_user', user);
  }

  Future<User?> getUser() async {
    return _userBox.get('current_user');
  }

  Future<void> deleteUser() async {
    await _userBox.delete('current_user');
  }

  // Cache Storage Methods
  Future<void> setCache(String key, dynamic value, {Duration? expiry}) async {
    final cacheData = {
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await _cacheBox.put(key, cacheData);
  }

  Future<dynamic> getCache(String key) async {
    final cacheData = _cacheBox.get(key);
    if (cacheData == null) return null;

    final timestamp = cacheData['timestamp'];
    final expiry = cacheData['expiry'];

    // Check if cache has expired
    if (expiry != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiry) {
        await _cacheBox.delete(key);
        return null;
      }
    }

    return cacheData['value'];
  }

  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  Future<void> removeCache(String key) async {
    await _cacheBox.delete(key);
  }

  // Settings Storage Methods (using SharedPreferences for simple key-value)
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return _prefs.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  // Settings Box Methods (using Hive for complex settings)
  Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  Future<dynamic> getSetting(String key) async {
    return _settingsBox.get(key);
  }

  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  Future<void> clearSettings() async {
    await _settingsBox.clear();
  }

  // Utility methods
  bool has(String key) {
    return _prefs.containsKey(key);
  }

  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  // Close all boxes
  Future<void> close() async {
    await _userBox.close();
    await _cacheBox.close();
    await _settingsBox.close();
  }
}

// Provider for StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  final storageService = StorageService();
  // Initialize storage when provider is created
  storageService.init();
  return storageService;
});

// Cache utilities
class CacheUtils {
  static const Duration defaultCacheDuration = Duration(minutes: 30);

  static String getCacheKey(String endpoint, [Map<String, dynamic>? params]) {
    if (params == null || params.isEmpty) {
      return endpoint;
    }

    final sortedParams = params.keys.toList()..sort();
    final paramStr = sortedParams.map((key) => '$key=${params[key]}').join('&');
    return '$endpoint?$paramStr';
  }

  static Duration getCacheDuration(String endpoint) {
    // Define different cache durations for different endpoints
    switch (endpoint) {
      case '/users/me':
        return const Duration(minutes: 15);
      case '/posts':
        return const Duration(minutes: 5);
      default:
        return defaultCacheDuration;
    }
  }
}
