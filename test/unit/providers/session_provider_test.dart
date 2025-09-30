import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:boilerplate_rivepod_flutter/shared/providers/session_provider.dart';
import 'package:boilerplate_rivepod_flutter/shared/services/auth_service.dart';
import 'package:boilerplate_rivepod_flutter/shared/services/storage_service.dart';
import 'package:boilerplate_rivepod_flutter/shared/models/user.dart';

import 'session_provider_test.mocks.dart';

@GenerateMocks([AuthService, StorageService])
void main() {
  group('SessionProvider Tests', () {
    late MockAuthService mockAuthService;
    late MockStorageService mockStorageService;
    late ProviderContainer container;

    setUp(() {
      mockAuthService = MockAuthService();
      mockStorageService = MockStorageService();

      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(mockAuthService),
          storageServiceProvider.overrideWithValue(mockStorageService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should not be initialized', () {
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;

      expect(sessionNotifier.state.isInitialized, false);
      expect(sessionNotifier.state.isAuthenticated, false);
      expect(sessionNotifier.state.user, null);
      expect(sessionNotifier.state.error, null);
    });

    test('should initialize session successfully when user is authenticated', () async {
      // Arrange
      when(mockStorageService.init()).thenAnswer((_) async {});
      when(mockAuthService.isAuthenticated()).thenAnswer((_) async => true);
      when(mockAuthService.getCurrentUser()).thenAnswer((_) async => const User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
      ));

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      await (sessionNotifier as dynamic)._initializeSession();

      // Assert
      expect(sessionNotifier.state.isInitialized, true);
      expect(sessionNotifier.state.isAuthenticated, true);
      expect(sessionNotifier.state.user?.email, 'test@example.com');
      expect(sessionNotifier.state.error, null);

      verify(mockStorageService.init()).called(1);
      verify(mockAuthService.isAuthenticated()).called(1);
      verify(mockAuthService.getCurrentUser()).called(1);
    });

    test('should initialize session with no authentication', () async {
      // Arrange
      when(mockStorageService.init()).thenAnswer((_) async {});
      when(mockAuthService.isAuthenticated()).thenAnswer((_) async => false);

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      await (sessionNotifier as dynamic)._initializeSession();

      // Assert
      expect(sessionNotifier.state.isInitialized, true);
      expect(sessionNotifier.state.isAuthenticated, false);
      expect(sessionNotifier.state.user, null);
      expect(sessionNotifier.state.error, null);

      verify(mockStorageService.init()).called(1);
      verify(mockAuthService.isAuthenticated()).called(1);
      verifyNever(mockAuthService.getCurrentUser());
    });

    test('should handle initialization error', () async {
      // Arrange
      when(mockStorageService.init()).thenThrow(Exception('Storage error'));

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      await (sessionNotifier as dynamic)._initializeSession();

      // Assert
      expect(sessionNotifier.state.isInitialized, true);
      expect(sessionNotifier.state.isAuthenticated, false);
      expect(sessionNotifier.state.error, 'Exception: Storage error');
    });

    test('should login successfully', () async {
      // Arrange
      const user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
      );
      when(mockAuthService.login('test@example.com', 'password'))
          .thenAnswer((_) async => user);

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      await sessionNotifier.login('test@example.com', 'password');

      // Assert
      expect(sessionNotifier.state.isAuthenticated, true);
      expect(sessionNotifier.state.user, user);
      expect(sessionNotifier.state.error, null);
    });

    test('should handle login error', () async {
      // Arrange
      when(mockAuthService.login('test@example.com', 'wrong_password'))
          .thenThrow(Exception('Invalid credentials'));

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      try {
        await sessionNotifier.login('test@example.com', 'wrong_password');
      } catch (e) {
        // Expected error
      }

      // Assert
      expect(sessionNotifier.state.isAuthenticated, false);
      expect(sessionNotifier.state.error, 'Exception: Invalid credentials');
    });

    test('should logout successfully', () async {
      // Arrange
      when(mockAuthService.logout()).thenAnswer((_) async {});

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      await sessionNotifier.logout();

      // Assert
      expect(sessionNotifier.state.isAuthenticated, false);
      expect(sessionNotifier.state.user, null);
      expect(sessionNotifier.state.error, null);
    });

    test('should update user successfully', () {
      // Arrange
      const updatedUser = User(
        id: '1',
        email: 'updated@example.com',
        name: 'Updated User',
      );

      // Act
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      sessionNotifier.updateUser(updatedUser);

      // Assert
      expect(sessionNotifier.state.user, updatedUser);
    });

    test('should clear error successfully', () {
      // Arrange
      final sessionNotifier = container.read(sessionProvider.notifier) as SessionNotifier;
      sessionNotifier.state = sessionNotifier.state.copyWith(error: 'Some error');

      // Act
      sessionNotifier.clearError();

      // Assert
      expect(sessionNotifier.state.error, null);
    });
  });

  group('SessionProvider Convenience Providers Tests', () {
    test('isAuthenticatedProvider should return correct value', () {
      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(
            (ref) => const SessionState(
              isInitialized: true,
              isAuthenticated: true,
              user: null,
            ),
          ),
        ],
      );

      final isAuthenticated = container.read(isAuthenticatedProvider);

      expect(isAuthenticated, true);

      container.dispose();
    });

    test('currentUserProvider should return correct user', () {
      const user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
      );

      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(
            (ref) => SessionState(
              isInitialized: true,
              isAuthenticated: true,
              user: user,
            ),
          ),
        ],
      );

      final currentUser = container.read(currentUserProvider);

      expect(currentUser, user);

      container.dispose();
    });

    test('isSessionInitializedProvider should return correct value', () {
      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(
            (ref) => const SessionState(
              isInitialized: true,
              isAuthenticated: false,
              user: null,
            ),
          ),
        ],
      );

      final isInitialized = container.read(isSessionInitializedProvider);

      expect(isInitialized, true);

      container.dispose();
    });
  });
}
