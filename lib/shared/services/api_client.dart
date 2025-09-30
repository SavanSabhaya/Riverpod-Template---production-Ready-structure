import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/api_response.dart';
import '../../core/config/app_config.dart';

class ApiClient {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.addAll([
      _createAuthInterceptor(),
      _createLoggingInterceptor(),
      _createErrorInterceptor(),
      _createRetryInterceptor(),
    ]);
  }

  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final token = await _getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the original request
            final response = await _dio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            handler.resolve(response);
            return;
          } else {
            // Refresh failed, logout user
            await _logout();
            handler.reject(error);
            return;
          }
        }
        handler.next(error);
      },
    );
  }

  Interceptor _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (AppConfig.enableLogging) {
          debugPrint('🚀 [API Request] ${options.method} ${options.uri}');
          debugPrint('Headers: ${options.headers}');
          if (options.data != null) {
            debugPrint('Body: ${options.data}');
          }
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (AppConfig.enableLogging) {
          debugPrint('✅ [API Response] ${response.statusCode} ${response.realUri}');
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (AppConfig.enableLogging) {
          debugPrint('❌ [API Error] ${error.response?.statusCode} ${error.requestOptions.uri}');
          debugPrint('Error: ${error.message}');
        }
        handler.next(error);
      },
    );
  }

  Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        // Transform DioError to ApiResponse.error
        final apiError = DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: _parseError(error),
        );
        handler.next(apiError);
      },
    );
  }

  Interceptor _createRetryInterceptor() {
    return RetryInterceptor(
      dio: _dio,
      options: RetryOptions(
        retries: 3,
        retryInterval: const Duration(seconds: 1),
        retryEvaluator: (error) {
          // Retry on network errors and 5xx status codes
          return error.type == DioExceptionType.connectionError ||
                 error.response?.statusCode == 500 ||
                 error.response?.statusCode == 502 ||
                 error.response?.statusCode == 503 ||
                 error.response?.statusCode == 504;
        },
      ),
    );
  }

  String _parseError(DioException error) {
    if (error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map<String, dynamic> && data['message'] != null) {
        return data['message'].toString();
      }
    }
    return error.message ?? 'Unknown error occurred';
  }

  // Authentication methods
  Future<String?> _getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await _storage.write(key: _accessTokenKey, value: data['accessToken']);
        if (data['refreshToken'] != null) {
          await _storage.write(key: _refreshTokenKey, value: data['refreshToken']);
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _logout() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // Public API methods
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<ApiResponse> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<ApiResponse> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<ApiResponse> patch(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<ApiResponse> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  // Authentication specific methods
  Future<ApiResponse> login(String email, String password) async {
    return post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }

  Future<ApiResponse> register(String email, String password, String name) async {
    return post('/auth/register', data: {
      'email': email,
      'password': password,
      'name': name,
    });
  }

  Future<ApiResponse> refreshToken() async {
    final refreshToken = await _getRefreshToken();
    if (refreshToken == null) {
      return const ApiResponse.error(
        message: 'No refresh token available',
        statusCode: 401,
      );
    }

    return post('/auth/refresh', data: {
      'refreshToken': refreshToken,
    });
  }

  Future<void> logout() async {
    await _logout();
  }

  // Token management
  Future<void> setTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<bool> hasValidToken() async {
    final token = await _getAccessToken();
    return token != null && token.isNotEmpty;
  }
}

// Provider for ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Retry interceptor implementation
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryOptions options;

  RetryInterceptor({
    required this.dio,
    this.options = const RetryOptions(),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var extra = err.requestOptions.extra;
    var retries = extra['retries'] ?? 0;

    if (retries < options.retries && options.retryEvaluator(err)) {
      retries++;
      err.requestOptions.extra['retries'] = retries;

      await Future.delayed(options.retryInterval);

      try {
        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}

class RetryOptions {
  final int retries;
  final Duration retryInterval;
  final bool Function(DioException error) retryEvaluator;

  const RetryOptions({
    this.retries = 3,
    this.retryInterval = const Duration(seconds: 1),
    this.retryEvaluator = _defaultRetryEvaluator,
  });

  static bool _defaultRetryEvaluator(DioException error) {
    return error.type == DioExceptionType.connectionError ||
           error.response?.statusCode == 500 ||
           error.response?.statusCode == 502 ||
           error.response?.statusCode == 503 ||
           error.response?.statusCode == 504;
  }
}
