import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../models/user.dart';

class SessionState {
  final bool isInitialized;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  const SessionState({
    required this.isInitialized,
    required this.isAuthenticated,
    this.user,
    this.error,
  });

  SessionState copyWith({
    bool? isInitialized,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return SessionState(
      isInitialized: isInitialized ?? this.isInitialized,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  final AuthService _authService;
  final StorageService _storageService;

  SessionNotifier(this._authService, this._storageService)
      : super(const SessionState(isInitialized: false, isAuthenticated: false)) {
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    try {
      // Initialize storage first
      await _storageService.init();

      // Check if user is authenticated
      final isAuthenticated = await _authService.isAuthenticated();

      if (isAuthenticated) {
        // Try to get current user
        final user = await _authService.getCurrentUser();
        state = SessionState(
          isInitialized: true,
          isAuthenticated: true,
          user: user,
        );
      } else {
        state = const SessionState(
          isInitialized: true,
          isAuthenticated: false,
        );
      }
    } catch (e) {
      state = SessionState(
        isInitialized: true,
        isAuthenticated: false,
        error: e.toString(),
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);
      state = SessionState(
        isInitialized: true,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = SessionState(
        isInitialized: true,
        isAuthenticated: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      final user = await _authService.register(email, password, name);
      state = SessionState(
        isInitialized: true,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = SessionState(
        isInitialized: true,
        isAuthenticated: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      state = const SessionState(
        isInitialized: true,
        isAuthenticated: false,
      );
    } catch (e) {
      // Even if logout fails, clear local state
      state = const SessionState(
        isInitialized: true,
        isAuthenticated: false,
      );
      rethrow;
    }
  }

  Future<void> refreshSession() async {
    try {
      final refreshed = await _authService.refreshToken();
      if (refreshed) {
        final user = await _authService.getCurrentUser();
        state = SessionState(
          isInitialized: true,
          isAuthenticated: true,
          user: user,
        );
      } else {
        // Refresh failed, logout
        await logout();
      }
    } catch (e) {
      await logout();
      rethrow;
    }
  }

  void updateUser(User user) {
    if (state.isAuthenticated) {
      state = state.copyWith(user: user);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Session Provider
final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return SessionNotifier(authService, storageService);
});

// Convenience providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(sessionProvider).isAuthenticated;
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(sessionProvider).user;
});

final isSessionInitializedProvider = Provider<bool>((ref) {
  return ref.watch(sessionProvider).isInitialized;
});
