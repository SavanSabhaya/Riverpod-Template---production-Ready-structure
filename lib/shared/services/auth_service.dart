import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/api_response.dart';
import 'api_client.dart';
import 'storage_service.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  final ApiClient _apiClient;
  final StorageService _storageService;

  AuthService(this._apiClient, this._storageService);

  // Simulate API delay for demo
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<bool> isAuthenticated() async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      // Try to get from storage first
      final cachedUser = await _storageService.getUser();
      if (cachedUser != null) {
        return cachedUser;
      }

      // If not in storage, try to fetch from API
      final response = await _apiClient.get('/auth/me');
      if (response is ApiResponseSuccess) {
        final userData = response.data;
        final user = User.fromJson(userData);
        await _storageService.saveUser(user);
        return user;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User> login(String email, String password) async {
    await _delay();

    // Simulate validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    try {
      // Real API call would go here
      final response = await _apiClient.login(email, password);

      if (response is ApiResponseSuccess) {
        final data = response.data;

        // Extract tokens and user data
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];
        final userData = data['user'];

        if (accessToken != null && refreshToken != null && userData != null) {
          // Store tokens
          await _apiClient.setTokens(accessToken, refreshToken);

          // Parse and store user
          final user = User.fromJson(userData);
          await _storageService.saveUser(user);

          return user;
        } else {
          throw Exception('Invalid response format');
        }
      } else if (response is ApiResponseError) {
        throw Exception(response.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<User> register(String email, String password, String name) async {
    await _delay();

    // Simulate validation
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('All fields are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    try {
      // Real API call would go here
      final response = await _apiClient.register(email, password, name);

      if (response is ApiResponseSuccess) {
        final data = response.data;

        // Extract tokens and user data
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];
        final userData = data['user'];

        if (accessToken != null && refreshToken != null && userData != null) {
          // Store tokens
          await _apiClient.setTokens(accessToken, refreshToken);

          // Parse and store user
          final user = User.fromJson(userData);
          await _storageService.saveUser(user);

          return user;
        } else {
          throw Exception('Invalid response format');
        }
      } else if (response is ApiResponseError) {
        throw Exception(response.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _delay();

    try {
      // Call logout API
      await _apiClient.logout();

      // Clear local storage
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storageService.deleteUser();
      await _storageService.clearCache();
    } catch (e) {
      // Even if API call fails, clear local data
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storageService.deleteUser();
      await _storageService.clearCache();
    }
  }

  Future<User> updateProfile(User updatedUser) async {
    await _delay();

    try {
      final response = await _apiClient.put('/auth/profile', data: updatedUser.toJson());

      if (response is ApiResponseSuccess) {
        final userData = response.data;
        final user = User.fromJson(userData);
        await _storageService.saveUser(user);
        return user;
      } else if (response is ApiResponseError) {
        throw Exception(response.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _delay();

    // Simulate validation
    if (newPassword.length < 6) {
      throw Exception('New password must be at least 6 characters');
    }

    try {
      final response = await _apiClient.post('/auth/change-password', data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      });

      if (response is ApiResponseError) {
        throw Exception(response.message);
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Password change failed: ${e.toString()}');
    }
  }

  Future<void> forgotPassword(String email) async {
    await _delay();

    // Simulate validation
    if (email.isEmpty) {
      throw Exception('Email is required');
    }

    try {
      final response = await _apiClient.post('/auth/forgot-password', data: {
        'email': email,
      });

      if (response is ApiResponseError) {
        throw Exception(response.message);
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Forgot password request failed: ${e.toString()}');
    }
  }

  Future<bool> deleteAccount() async {
    await _delay();

    try {
      final response = await _apiClient.delete('/auth/account');

      if (response is ApiResponseSuccess) {
        await logout();
        return true;
      } else if (response is ApiResponseError) {
        throw Exception(response.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Account deletion failed: ${e.toString()}');
    }
  }

  Future<bool> refreshToken() async {
    try {
      final response = await _apiClient.refreshToken();

      if (response is ApiResponseSuccess) {
        final data = response.data;
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          await _apiClient.setTokens(accessToken, refreshToken);
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}

// Updated Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storageService = ref.watch(storageServiceProvider);
  return AuthService(apiClient, storageService);
});
