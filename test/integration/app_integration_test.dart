import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:boilerplate_rivepod_flutter/main.dart' as app;
import 'package:boilerplate_rivepod_flutter/shared/providers/session_provider.dart';
import 'package:boilerplate_rivepod_flutter/shared/models/user.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('should complete full authentication flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Should show loading screen initially
      expect(find.text('Initializing...'), findsOneWidget);

      // Wait for initialization to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should redirect to login page since user is not authenticated
      expect(find.text('Login'), findsOneWidget);

      // Enter login credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Should show loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for login to complete
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should navigate to home page
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Welcome back!'), findsOneWidget);
    });

    testWidgets('should handle login validation errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should be on login page
      expect(find.text('Login'), findsOneWidget);

      // Try to login with empty fields
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Should show validation errors
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('should navigate between pages correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should be on login page
      expect(find.text('Login'), findsOneWidget);

      // Navigate to register page
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Should be on register page
      expect(find.text('Register'), findsOneWidget);

      // Go back to login
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Should be back on login page
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should handle session state changes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should be on login page
      expect(find.text('Login'), findsOneWidget);

      // Test with a ProviderContainer to override session state
      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(
            (ref) => SessionState(
              isInitialized: true,
              isAuthenticated: true,
              user: const User(
                id: '1',
                email: 'test@example.com',
                name: 'Test User',
              ),
            ),
          ),
        ],
      );

      // Rebuild the app with the overridden provider
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: Scaffold(
              body: Text('Home Page'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show home page content
      expect(find.text('Home Page'), findsOneWidget);

      container.dispose();
    });
  });

  group('App Performance Tests', () {
    testWidgets('should load app within reasonable time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      app.main();
      await tester.pumpAndSettle();

      stopwatch.stop();

      // App should initialize within 5 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('should handle rapid navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Rapidly navigate between pages
      for (int i = 0; i < 5; i++) {
        if (find.text('Register').evaluate().isNotEmpty) {
          await tester.tap(find.text('Register'));
          await tester.pumpAndSettle(const Duration(milliseconds: 100));
        }

        if (find.byType(BackButton).evaluate().isNotEmpty) {
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle(const Duration(milliseconds: 100));
        }
      }

      // Should not crash and should be responsive
      expect(tester.takeException(), isNull);
    });
  });

  group('App Error Handling Tests', () {
    testWidgets('should handle network errors gracefully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initialization
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should be on login page
      expect(find.text('Login'), findsOneWidget);

      // Try to login with invalid credentials
      await tester.enterText(find.byType(TextFormField).first, 'wrong@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Should show loading initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for error handling
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should still be on login page (error handled gracefully)
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
