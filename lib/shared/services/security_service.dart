import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/helpers.dart';
import 'logging_service.dart';

class SecurityService {
  static const String _encryptionKey = 'encryption_key';
  static const String _saltKey = 'encryption_salt';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Encryption setup
  late encrypt.Encrypter _encrypter;
  late encrypt.IV _iv;

  SecurityService() {
    _initializeEncryption();
  }

  void _initializeEncryption() {
    // Generate or retrieve encryption key
    final key = _getOrCreateEncryptionKey();
    final iv = encrypt.IV.fromLength(16); // 128-bit IV

    _encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key)));
    _iv = iv;
  }

  String _getOrCreateEncryptionKey() {
    // In a real app, this would be derived from a hardware-backed keystore
    // For demo purposes, we'll use a fixed key
    const fallbackKey = 'your-256-bit-encryption-key-here';
    return fallbackKey.padRight(32, '0').substring(0, 32);
  }

  // Secure token storage
  Future<void> storeToken(String key, String token) async {
    final encryptedToken = _encrypt(token);
    await _storage.write(key: key, value: encryptedToken);
  }

  Future<String?> retrieveToken(String key) async {
    final encryptedToken = await _storage.read(key: key);
    if (encryptedToken == null) return null;

    return _decrypt(encryptedToken);
  }

  Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  // Data encryption/decryption
  String _encrypt(String data) {
    try {
      final encrypted = _encrypter.encrypt(data, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      logError('Encryption failed', data: {'error': e.toString()});
      return data; // Fallback to plain text in case of error
    }
  }

  String _decrypt(String encryptedData) {
    try {
      final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
      return decrypted;
    } catch (e) {
      logError('Decryption failed', data: {'error': e.toString()});
      return encryptedData; // Return as-is if decryption fails
    }
  }

  // Password hashing
  String hashPassword(String password, {String? salt}) {
    final saltToUse = salt ?? _generateSalt();
    final saltedPassword = saltToUse + password;

    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);

    return '$saltToUse:${digest.toString()}';
  }

  bool verifyPassword(String password, String hashedPassword) {
    try {
      final parts = hashedPassword.split(':');
      if (parts.length != 2) return false;

      final salt = parts[0];
      final hash = parts[1];

      final testHash = hashPassword(password, salt: salt);
      final testParts = testHash.split(':');

      return testParts[1] == hash;
    } catch (e) {
      return false;
    }
  }

  String _generateSalt() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Helpers.generateRandomString(16);
    return random;
  }

  // Input validation helpers
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // At least 8 characters, contains uppercase, lowercase, number, and special character
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }

  static bool isValidPhone(String phone) {
    // Basic phone validation - adjust regex based on your requirements
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone.replaceAll(RegExp(r'\s+'), ''));
  }

  static String sanitizeInput(String input) {
    // Remove potentially dangerous characters
    return input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll('\'', '')
        .replaceAll(';', '')
        .replaceAll('&', '')
        .trim();
  }

  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  // Secure random string generation
  String generateSecureToken({int length = 32}) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final secureRandom = Helpers.generateRandomString(length);
    return secureRandom;
  }

  // Data masking for logs
  String maskSensitiveData(String data, {int visibleChars = 4}) {
    if (data.length <= visibleChars * 2) {
      return '*' * data.length;
    }

    final start = data.substring(0, visibleChars);
    final end = data.substring(data.length - visibleChars);
    return '$start${'*' * (data.length - visibleChars * 2)}$end';
  }

  // Certificate pinning for SSL
  bool validateCertificate(String certificate, String expectedFingerprint) {
    try {
      final bytes = utf8.encode(certificate);
      final digest = sha256.convert(bytes);
      return digest.toString() == expectedFingerprint;
    } catch (e) {
      return false;
    }
  }

  // Rate limiting helper
  static const Map<String, Duration> _rateLimits = {
    'login': Duration(minutes: 5),
    'registration': Duration(hours: 1),
    'password_reset': Duration(minutes: 15),
  };

  bool isRateLimited(String action, DateTime lastAttempt) {
    final limit = _rateLimits[action];
    if (limit == null) return false;

    return DateTime.now().difference(lastAttempt) < limit;
  }

  // Biometric authentication check
  Future<bool> isBiometricAvailable() async {
    try {
      // This would integrate with local_auth package
      // For demo purposes, return false
      return false;
    } catch (e) {
      return false;
    }
  }

  // Device security checks
  Future<SecurityStatus> checkDeviceSecurity() async {
    // This would check for:
    // - Root/jailbreak detection
    // - Emulator detection
    // - Debug mode detection
    // - Screen lock enabled
    // - Biometric authentication available

    return SecurityStatus(
      isRooted: false, // Would implement actual check
      isEmulator: false, // Would implement actual check
      isDebugMode: Helpers.isDebugMode,
      hasScreenLock: true, // Would implement actual check
      hasBiometric: await isBiometricAvailable(),
    );
  }
}

class SecurityStatus {
  final bool isRooted;
  final bool isEmulator;
  final bool isDebugMode;
  final bool hasScreenLock;
  final bool hasBiometric;

  const SecurityStatus({
    required this.isRooted,
    required this.isEmulator,
    required this.isDebugMode,
    required this.hasScreenLock,
    required this.hasBiometric,
  });

  bool get isSecure => !isRooted && !isEmulator && hasScreenLock;
  bool get needsAttention => isRooted || isEmulator || !hasScreenLock;
}

// Provider for SecurityService
final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService();
});

// Input validation helpers
class ValidationHelpers {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!SecurityService.isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (!SecurityService.isValidPassword(password)) {
      return 'Password must be at least 8 characters with uppercase, lowercase, number, and special character';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return null; // Phone is optional
    }
    if (!SecurityService.isValidPhone(phone)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }

  static String? validateUrl(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }
    if (!SecurityService.isValidUrl(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }
}
