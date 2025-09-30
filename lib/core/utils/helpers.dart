import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

class Helpers {
  // Debounce function
  static Timer? _debounceTimer;
  static void debounce(VoidCallback callback, {Duration duration = AppConstants.debounceDuration}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  // Throttle function
  static Timer? _throttleTimer;
  static void throttle(VoidCallback callback, {Duration duration = AppConstants.debounceDuration}) {
    if (_throttleTimer?.isActive ?? false) return;
    _throttleTimer = Timer(duration, callback);
  }

  // Check if email is valid
  static bool isValidEmail(String email) {
    return RegExp(AppConstants.emailRegex).hasMatch(email);
  }

  // Check if phone number is valid
  static bool isValidPhone(String phone) {
    return RegExp(AppConstants.phoneRegex).hasMatch(phone);
  }

  // Check if password is strong
  static bool isValidPassword(String password) {
    return RegExp(AppConstants.passwordRegex).hasMatch(password);
  }

  // Format phone number
  static String formatPhoneNumber(String phone) {
    // Remove all non-digits
    String cleaned = phone.replaceAll(RegExp(r'\D'), '');

    // Add country code if not present
    if (cleaned.length == 10) {
      cleaned = '+1$cleaned'; // Assuming US format
    }

    return cleaned;
  }

  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Generate random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Check if string is numeric
  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  // Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }

  // Copy to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  // Launch URL
  static Future<bool> launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri.toString());
    } catch (e) {
      return false;
    }
  }

  // Check internet connectivity
  static Future<bool> isConnected() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  // Format duration
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  // Parse JSON safely
  static T? parseJson<T>(String jsonString, T Function(Map<String, dynamic>) fromJson) {
    try {
      final map = json.decode(jsonString) as Map<String, dynamic>;
      return fromJson(map);
    } catch (e) {
      return null;
    }
  }

  // Encode JSON safely
  static String? encodeJson(Object? object) {
    try {
      return json.encode(object);
    } catch (e) {
      return null;
    }
  }

  // Check if list is null or empty
  static bool isNullOrEmpty<T>(List<T>? list) {
    return list == null || list.isEmpty;
  }

  // Check if string is null or empty
  static bool isNullOrEmptyString(String? str) {
    return str == null || str.trim().isEmpty;
  }

  // Get initials from name
  static String getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  // Validate URL
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  // Format number with commas
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  // Check if app is in debug mode
  static bool get isDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  // Print debug message
  static void debugPrint(String message) {
    if (isDebugMode) {
      print('DEBUG: $message');
    }
  }

  // Measure execution time
  static Future<T> measureExecutionTime<T>(Future<T> Function() function, {String? label}) async {
    final stopwatch = Stopwatch()..start();
    final result = await function();
    stopwatch.stop();
    debugPrint('${label ?? 'Execution'} time: ${stopwatch.elapsedMilliseconds}ms');
    return result;
  }
}
