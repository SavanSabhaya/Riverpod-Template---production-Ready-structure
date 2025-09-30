import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../shared/providers/session_provider.dart';

// Route names
class RouteNames {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String profile = 'profile';
}

// Route paths
class RoutePaths {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
}

// Auth guard function
bool _isAuthenticated(GoRouterState state) {
  // This would check if user is authenticated
  // For now, return true for demo purposes
  return true;
}

// Public routes guard
bool _isNotAuthenticated(GoRouterState state) {
  // This would check if user is not authenticated
  return true;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final sessionState = ref.watch(sessionProvider);

  return GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = sessionState.isAuthenticated;
      final isAuthRoute = state.matchedLocation == RoutePaths.login ||
                         state.matchedLocation == RoutePaths.register;

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && !isAuthRoute) {
        return RoutePaths.login;
      }

      // If authenticated and trying to access auth routes
      if (isAuthenticated && isAuthRoute) {
        return RoutePaths.home;
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),

      // Main App Routes
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          // Nested routes for main app
          GoRoute(
            path: 'profile',
            name: RouteNames.profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // Splash and Onboarding routes would go here
      // GoRoute(
      //   path: RoutePaths.splash,
      //   name: RouteNames.splash,
      //   builder: (context, state) => const SplashPage(),
      // ),
      // GoRoute(
      //   path: RoutePaths.onboarding,
      //   name: RouteNames.onboarding,
      //   builder: (context, state) => const OnboardingPage(),
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.error}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    ),
  );
});

// Extension for easy navigation
extension GoRouterNavigationExtension on BuildContext {
  GoRouter get router => GoRouter.of(this);

  void goToLogin() => router.go(RoutePaths.login);
  void goToRegister() => router.go(RoutePaths.register);
  void goToHome() => router.go(RoutePaths.home);
  void goToProfile() => router.go(RoutePaths.profile);

  void pushToLogin() => router.push(RoutePaths.login);
  void pushToRegister() => router.push(RoutePaths.register);
  void pushToHome() => router.push(RoutePaths.home);
  void pushToProfile() => router.push(RoutePaths.profile);

  void goBack() => router.pop();
  bool get canGoBack => router.canPop();
}

// Navigation helpers
class NavigationHelpers {
  static void navigateToLogin(BuildContext context) {
    context.goToLogin();
  }

  static void navigateToRegister(BuildContext context) {
    context.goToRegister();
  }

  static void navigateToHome(BuildContext context) {
    context.goToHome();
  }

  static void navigateToProfile(BuildContext context) {
    context.goToProfile();
  }

  static void goBack(BuildContext context) {
    if (context.canGoBack) {
      context.goBack();
    }
  }
}
