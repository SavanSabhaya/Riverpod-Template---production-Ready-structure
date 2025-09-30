import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

class LogEntry {
  final LogLevel level;
  final String message;
  final DateTime timestamp;
  final String? tag;
  final Map<String, dynamic>? data;
  final StackTrace? stackTrace;

  const LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.tag,
    this.data,
    this.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write('[${timestamp.toIso8601String()}] ');
    buffer.write('[${level.name.toUpperCase()}] ');

    if (tag != null) {
      buffer.write('[$tag] ');
    }

    buffer.write(message);

    if (data != null && data!.isNotEmpty) {
      buffer.write(' | Data: $data');
    }

    return buffer.toString();
  }
}

class LoggingService {
  static const String _defaultTag = 'FlutterBoilerplate';
  final List<LogEntry> _logs = [];
  final int _maxLogs = 1000;

  // Singleton pattern
  static LoggingService? _instance;
  static LoggingService get instance => _instance ??= LoggingService._();

  LoggingService._();

  void debug(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  void info(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  void warning(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  void error(String message, {String? tag, Map<String, dynamic>? data, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag: tag, data: data, stackTrace: stackTrace);
  }

  void fatal(String message, {String? tag, Map<String, dynamic>? data, StackTrace? stackTrace}) {
    _log(LogLevel.fatal, message, tag: tag, data: data, stackTrace: stackTrace);
  }

  void _log(LogLevel level, String message, {String? tag, Map<String, dynamic>? data, StackTrace? stackTrace}) {
    final entry = LogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
      tag: tag ?? _defaultTag,
      data: data,
      stackTrace: stackTrace,
    );

    _addLog(entry);

    // Console logging in debug mode
    if (kDebugMode) {
      _logToConsole(entry);
    }

    // Send to analytics service if error or fatal
    if (level == LogLevel.error || level == LogLevel.fatal) {
      _sendToAnalytics(entry);
    }
  }

  void _addLog(LogEntry entry) {
    _logs.add(entry);

    // Keep only the latest logs
    if (_logs.length > _maxLogs) {
      _logs.removeRange(0, _logs.length - _maxLogs);
    }
  }

  void _logToConsole(LogEntry entry) {
    final message = entry.toString();

    switch (entry.level) {
      case LogLevel.debug:
        developer.log(message, name: entry.tag!);
        break;
      case LogLevel.info:
        developer.log(message, name: entry.tag!);
        break;
      case LogLevel.warning:
        developer.log(message, name: entry.tag!);
        break;
      case LogLevel.error:
        developer.log(message, name: entry.tag!, error: entry.stackTrace);
        break;
      case LogLevel.fatal:
        developer.log(message, name: entry.tag!, error: entry.stackTrace);
        break;
    }
  }

  void _sendToAnalytics(LogEntry entry) {
    // This would integrate with Firebase Crashlytics or other analytics services
    // For now, we'll just log it
    developer.log('📊 [Analytics] ${entry.toString()}', name: 'Analytics');
  }

  // Get logs for debugging
  List<LogEntry> getLogs({LogLevel? minLevel, String? tag}) {
    return _logs.where((entry) {
      if (minLevel != null && entry.level.index < minLevel.index) {
        return false;
      }
      if (tag != null && entry.tag != tag) {
        return false;
      }
      return true;
    }).toList();
  }

  // Clear logs
  void clearLogs() {
    _logs.clear();
  }

  // Export logs for debugging
  String exportLogs() {
    final buffer = StringBuffer();
    buffer.writeln('=== Flutter Boilerplate Logs ===');
    buffer.writeln('Generated at: ${DateTime.now().toIso8601String()}');
    buffer.writeln('');

    for (final entry in _logs) {
      buffer.writeln(entry.toString());
    }

    return buffer.toString();
  }
}

// Convenience functions
void logDebug(String message, {String? tag, Map<String, dynamic>? data}) {
  LoggingService.instance.debug(message, tag: tag, data: data);
}

void logInfo(String message, {String? tag, Map<String, dynamic>? data}) {
  LoggingService.instance.info(message, tag: tag, data: data);
}

void logWarning(String message, {String? tag, Map<String, dynamic>? data}) {
  LoggingService.instance.warning(message, tag: tag, data: data);
}

void logError(String message, {String? tag, Map<String, dynamic>? data, StackTrace? stackTrace}) {
  LoggingService.instance.error(message, tag: tag, data: data, stackTrace: stackTrace);
}

void logFatal(String message, {String? tag, Map<String, dynamic>? data, StackTrace? stackTrace}) {
  LoggingService.instance.fatal(message, tag: tag, data: data, stackTrace: stackTrace);
}

// Analytics service integration
class AnalyticsService {
  static AnalyticsService? _instance;
  static AnalyticsService get instance => _instance ??= AnalyticsService._();

  AnalyticsService._();

  void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    LoggingService.instance.info('📊 Analytics Event: $eventName', data: parameters);

    // This would integrate with Firebase Analytics or other services
    // Example:
    // await FirebaseAnalytics.instance.logEvent(
    //   name: eventName,
    //   parameters: parameters,
    // );
  }

  void logUserProperty(String name, String value) {
    LoggingService.instance.info('📊 User Property: $name = $value');

    // This would integrate with Firebase Analytics
    // Example:
    // await FirebaseAnalytics.instance.setUserProperty(
    //   name: name,
    //   value: value,
    // );
  }

  void setUserId(String userId) {
    LoggingService.instance.info('📊 Set User ID: $userId');

    // This would integrate with Firebase Analytics
    // Example:
    // await FirebaseAnalytics.instance.setUserId(userId);
  }

  void logScreenView(String screenName, String screenClass) {
    LoggingService.instance.info('📊 Screen View: $screenName');

    // This would integrate with Firebase Analytics
    // Example:
    // await FirebaseAnalytics.instance.logScreenView(
    //   screenName: screenName,
    //   screenClass: screenClass,
    // );
  }

  void logError(String message, {StackTrace? stackTrace, Map<String, dynamic>? context}) {
    LoggingService.instance.error('🚨 Analytics Error: $message', data: context, stackTrace: stackTrace);

    // This would integrate with Firebase Crashlytics
    // Example:
    // await FirebaseCrashlytics.instance.recordError(
    //   message,
    //   stackTrace,
    //   context,
    // );
  }

  void logPerformance(String operation, Duration duration, {Map<String, dynamic>? metadata}) {
    LoggingService.instance.info('📊 Performance: $operation took ${duration.inMilliseconds}ms', data: metadata);

    // This would integrate with Firebase Performance Monitoring
    // Example:
    // final trace = FirebasePerformance.instance.newTrace(operation);
    // trace.putAttribute('duration', duration.inMilliseconds.toString());
    // await trace.stop();
  }
}

// Provider for LoggingService
final loggingServiceProvider = Provider<LoggingService>((ref) {
  return LoggingService.instance;
});

// Provider for AnalyticsService
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService.instance;
});

// Analytics helpers
class AnalyticsHelpers {
  static void logLogin(String method) {
    AnalyticsService.instance.logEvent('login', parameters: {
      'method': method,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static void logRegistration(String method) {
    AnalyticsService.instance.logEvent('registration', parameters: {
      'method': method,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static void logScreenView(String screenName) {
    AnalyticsService.instance.logScreenView(screenName, screenName);
  }

  static void logButtonTap(String buttonName, String screenName) {
    AnalyticsService.instance.logEvent('button_tap', parameters: {
      'button_name': buttonName,
      'screen_name': screenName,
    });
  }

  static void logError(String error, String screenName, {StackTrace? stackTrace}) {
    AnalyticsService.instance.logError(
      error,
      stackTrace: stackTrace,
      context: {'screen': screenName},
    );
  }

  static void logPerformance(String operation, Duration duration) {
    AnalyticsService.instance.logPerformance(operation, duration);
  }

  static void setUserProperties(User user) {
    AnalyticsService.instance.setUserId(user.id);
    AnalyticsService.instance.logUserProperty('user_name', user.name);
    AnalyticsService.instance.logUserProperty('user_email', user.email);
  }
}
