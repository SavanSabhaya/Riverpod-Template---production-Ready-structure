# Flutter Boilerplate with Riverpod

A production-ready Flutter project boilerplate with modern architecture patterns, state management using Riverpod 2.x, navigation with GoRouter, and comprehensive tooling setup.

## 🚀 Features

### Architecture & Structure
- **Clean Architecture**: Feature-based folder structure with clear separation of concerns
- **Riverpod 2.x**: Modern state management with providers, state notifiers, and future providers
- **GoRouter**: Type-safe navigation with deep linking and nested routes
- **Repository Pattern**: Centralized data access layer

### Core Features
- **Environment Configuration**: Multi-environment support (dev, staging, prod) with flutter_dotenv
- **Theme Management**: Light/dark theme support with Material 3 design system
- **Localization**: Internationalization support with easy_localization
- **Error Handling**: Centralized error handling and loading states
- **Network Layer**: Dio-based HTTP client with interceptors and error handling
- **Local Storage**: Secure storage with encryption and Hive for complex data

### Developer Experience
- **Code Generation**: Freezed for immutable models, JSON serialization
- **Linting**: Very Good Analysis for code quality and consistency
- **Testing**: Mockito for unit testing and widget testing setup
- **Responsive Design**: Flutter ScreenUtil for responsive UI across devices

## 📁 Project Structure

```
lib/
├── core/                          # Core application layer
│   ├── config/                    # Environment and app configuration
│   │   └── app_config.dart
│   ├── constants/                 # App constants and themes
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_constants.dart
│   ├── router/                    # Navigation configuration
│   │   └── app_router.dart
│   ├── theme/                     # Theme management
│   │   └── app_theme.dart
│   └── utils/                     # Utility functions and extensions
│       └── helpers.dart
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   └── presentation/
│   │       └── pages/
│   │           ├── login_page.dart
│   │           └── register_page.dart
│   ├── home/                      # Home feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart
│   └── profile/                   # Profile feature
│       └── presentation/
│           └── pages/
│               └── profile_page.dart
├── shared/                        # Shared code across features
│   ├── models/                    # Data models
│   │   ├── auth_state.dart
│   │   └── user.dart
│   ├── providers/                 # Riverpod providers
│   │   └── auth_provider.dart
│   ├── services/                  # Business logic and API services
│   │   └── auth_service.dart
│   └── widgets/                   # Reusable UI components
│       ├── app_button.dart
│       └── app_loading_indicator.dart
├── app.dart                       # Main app widget
└── main.dart                      # Application entry point
```

## 🛠️ Setup & Installation

### Prerequisites
- Flutter 3.9.2 or higher
- Dart 3.9.2 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd boilerplate_rivepod_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Create environment file**
   ```bash
   cp .env.example .env
   ```

   Update the `.env` file with your configuration:
   ```env
   ENVIRONMENT=development
   API_BASE_URL_DEV=http://localhost:3000/api/v1
   APP_NAME=Your App Name
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# Environment Configuration
ENVIRONMENT=development

# API Configuration
API_BASE_URL_DEV=http://localhost:3000/api/v1
API_BASE_URL_STAGING=https://api.staging.example.com/api/v1
API_BASE_URL_PRODUCTION=https://api.example.com/api/v1

# App Configuration
APP_NAME=Flutter Boilerplate
ENABLE_LOGGING=true
ENABLE_CRASH_REPORTING=false

# Third-party Services
# SENTRY_DSN=your-sentry-dsn
# FIREBASE_API_KEY=your-firebase-key
```

### App Configuration

The app configuration is handled in `lib/core/config/app_config.dart`:

```dart
class AppConfig {
  static Environment get environment => // Environment detection
  static String get apiBaseUrl => // API base URL based on environment
  static String get appName => // App name from environment
  static bool get enableLogging => // Logging configuration
}
```

## 🎨 Theming

The app uses Material 3 design system with custom theming:

```dart
// Light Theme
ThemeData lightTheme = AppTheme.lightTheme;

// Dark Theme
ThemeData darkTheme = AppTheme.darkTheme;

// Usage in widgets
Container(
  color: Theme.of(context).primaryColor,
  child: Text(
    'Hello World',
    style: Theme.of(context).textTheme.headlineMedium,
  ),
)
```

## 🌐 Localization

The app supports multiple languages with easy_localization:

### Adding Translations

1. Add translations to `assets/translations/`:
   ```json
   // assets/translations/en-US.json
   {
     "hello": "Hello",
     "welcome": "Welcome back!"
   }
   ```

2. Use in widgets:
   ```dart
   Text('hello'.tr())
   Text('welcome'.tr())
   ```

### Supported Locales

- English (US) - `en-US`
- Spanish (Spain) - `es-ES`
- French (France) - `fr-FR`

## 🔄 State Management

The app uses Riverpod 2.x for state management:

### Provider Types

```dart
// State Provider
final counterProvider = StateProvider<int>((ref) => 0);

// State Notifier Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

// Future Provider
final userProvider = FutureProvider<User>((ref) async {
  return ref.watch(authServiceProvider).getCurrentUser();
});
```

### Usage in Widgets

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) => Text('Hello ${user.name}'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## 🧭 Navigation

The app uses GoRouter for type-safe navigation:

### Route Configuration

Routes are defined in `lib/core/router/app_router.dart`:

```dart
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
    ],
  );
});
```

### Navigation in Widgets

```dart
// Navigate to a route
context.go('/home');
context.push('/profile');

// Navigate with parameters
context.go('/user/123');

// Go back
context.pop();
```

## 🧪 Testing

The project includes testing setup with Mockito:

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/auth_test.dart
```

### Writing Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('AuthService', () {
    test('should login successfully', () async {
      // Arrange
      final authService = AuthService();

      // Act
      final user = await authService.login('test@example.com', 'password');

      // Assert
      expect(user.email, 'test@example.com');
    });
  });
}
```

## 📱 Responsive Design

The app uses Flutter ScreenUtil for responsive design:

```dart
// Design sizes based on iPhone 12 Pro
ScreenUtilInit(
  designSize: Size(375, 812),
  builder: (context, child) {
    return Text(
      'Responsive Text',
      style: TextStyle(fontSize: 16.sp), // Responsive font size
    );
  },
);
```

## 🔒 Security

The app includes security best practices:

- **Secure Storage**: Encrypted local storage for sensitive data
- **Environment Variables**: Secure configuration management
- **Input Validation**: Comprehensive form validation
- **Error Handling**: Secure error messages without exposing sensitive information

## 🚀 Deployment

### Build for Production

```bash
# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build Web
flutter build web --release
```

### Environment Setup

1. Create environment-specific configuration files:
   - `.env.development`
   - `.env.staging`
   - `.env.production`

2. Update `lib/core/config/app_config.dart` for environment detection

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support, email support@example.com or create an issue in the repository.

## 🔄 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes and version history.

---

**Happy coding! 🎉**
