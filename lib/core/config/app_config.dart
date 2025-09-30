import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  static Environment get environment {
    const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
    switch (env) {
      case 'staging':
        return Environment.staging;
      case 'production':
        return Environment.production;
      default:
        return Environment.development;
    }
  }

  static String get apiBaseUrl {
    switch (environment) {
      case Environment.staging:
        return dotenv.get('API_BASE_URL_STAGING', fallback: 'https://api.staging.example.com');
      case Environment.production:
        return dotenv.get('API_BASE_URL_PRODUCTION', fallback: 'https://api.example.com');
      default:
        return dotenv.get('API_BASE_URL_DEV', fallback: 'http://localhost:3000');
    }
  }

  static String get appName {
    return dotenv.get('APP_NAME', fallback: 'Flutter Boilerplate');
  }

  static bool get enableLogging {
    return dotenv.get('ENABLE_LOGGING', fallback: 'true').toLowerCase() == 'true';
  }

  static bool get enableCrashReporting {
    return dotenv.get('ENABLE_CRASH_REPORTING', fallback: 'false').toLowerCase() == 'true';
  }

  static String get sentryDsn {
    return dotenv.get('SENTRY_DSN', fallback: '');
  }

  static bool get isDevelopment => environment == Environment.development;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.production;
}
