# 🚀 Ultimate Flutter Production Boilerplate

A comprehensive, production-ready Flutter project boilerplate with modern architecture patterns, advanced state management, comprehensive testing, monitoring, security, and DevOps setup.

## ✨ What's Included

### 🏗️ **Architecture & Structure**
- **Clean Architecture** with feature-based folder structure
- **Riverpod 2.x** for modern state management
- **GoRouter** for type-safe navigation with deep linking
- **Repository Pattern** for centralized data access
- **Dependency Injection** with Provider pattern

### 🔧 **Core Features**
- **Environment Configuration** (dev/staging/prod) with flutter_dotenv
- **Theme Management** with Material 3 light/dark themes
- **Internationalization** with easy_localization (multi-language support)
- **Error Handling** with centralized error management
- **Loading States** throughout the application
- **Offline-First Architecture** with caching strategies

### 🌐 **Advanced Networking**
- **Dio HTTP Client** with comprehensive configuration
- **Authentication Interceptors** for JWT token injection
- **Logging Interceptors** for request/response debugging
- **Error Interceptors** for centralized error handling
- **Retry Interceptors** with configurable retry policies
- **SSL Pinning** support for enhanced security

### 🔐 **Security & Authentication**
- **JWT Token Management** with access and refresh tokens
- **Secure Storage** with encryption using flutter_secure_storage
- **Biometric Authentication** support
- **Password Hashing** with salt
- **Input Validation** and sanitization
- **Rate Limiting** for API endpoints
- **Certificate Pinning** for SSL security

### 💾 **Data Persistence**
- **Hive Database** for complex data storage
- **SharedPreferences** for simple key-value storage
- **Cache Layer** with automatic expiry and cleanup
- **Offline Sync** strategies
- **Data Encryption** at rest

### 📊 **Monitoring & Analytics**
- **Comprehensive Logging** with debug/info/error/fatal levels
- **Firebase Crashlytics** integration ready
- **Firebase Analytics** setup for user behavior tracking
- **Performance Monitoring** with Firebase Performance
- **Custom Analytics Events** for business metrics

### 🧪 **Testing Infrastructure**
- **Unit Tests** for Riverpod providers and services
- **Widget Tests** with comprehensive UI testing
- **Integration Tests** for full app workflows
- **Golden Tests** for visual regression testing
- **Mock APIs** for testing network-dependent features
- **Provider Overrides** for isolated testing

### 🚀 **DevOps & Build Pipeline**
- **GitHub Actions** CI/CD pipeline
- **Multi-Platform Builds** (Android, iOS, Web)
- **Automated Testing** in CI pipeline
- **Code Coverage** reporting with Codecov
- **Build Scripts** for automated builds
- **Environment-Specific Configuration**

### 🎨 **UI/UX Polish**
- **Responsive Design** with Flutter ScreenUtil
- **Accessibility Support** (WCAG 2.1 AA compliance)
- **Dynamic Theming** with user preference persistence
- **Font Scaling** support for accessibility
- **High Contrast Mode** support
- **Touch Target Optimization** for better usability

### 📱 **Platform Features**
- **Push Notifications** with Firebase Messaging
- **Background Tasks** with Workmanager
- **File Upload/Download** with progress tracking
- **Image Caching** with cached_network_image
- **Deep Linking** support

## 📁 **Project Structure**

```
lib/
├── core/                          # Core application layer
│   ├── config/                    # Environment & app configuration
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
│       ├── helpers.dart
│       └── accessibility_helper.dart
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
│   │   ├── api_response.dart
│   │   ├── auth_state.dart
│   │   └── user.dart
│   ├── providers/                 # Riverpod providers
│   │   ├── auth_provider.dart
│   │   ├── session_provider.dart
│   │   └── theme_provider.dart
│   ├── services/                  # Business logic & API services
│   │   ├── api_client.dart
│   │   ├── auth_service.dart
│   │   ├── storage_service.dart
│   │   ├── logging_service.dart
│   │   └── security_service.dart
│   └── widgets/                   # Reusable UI components
│       ├── app_button.dart
│       └── app_loading_indicator.dart
├── app.dart                       # Main app widget with providers
└── main.dart                      # Application entry point

test/                              # Testing infrastructure
├── unit/                          # Unit tests
│   └── providers/
├── widget/                        # Widget tests
├── integration/                   # Integration tests
└── golden/                        # Golden tests

.github/workflows/                 # CI/CD pipelines
├── ci.yml                         # Main CI/CD workflow

scripts/                           # Build and utility scripts
├── build.sh                       # Multi-platform build script

assets/                            # Static assets
├── translations/                  # Localization files
│   └── en-US.json
└── .env                          # Environment configuration
```

## 🛠️ **Quick Start**

### Prerequisites
- Flutter 3.9.2 or higher
- Dart 3.9.2 or higher
- Android Studio (for Android development)
- Xcode (for iOS development, macOS only)

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

4. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Build for all platforms
./scripts/build.sh all production

# Build specific platform
./scripts/build.sh android production
./scripts/build.sh ios production
./scripts/build.sh web production
```

## 🔧 **Configuration**

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

# Security
ENCRYPTION_KEY=your-256-bit-encryption-key-here

# Firebase Configuration (add when setting up Firebase)
# FIREBASE_API_KEY=your-firebase-api-key
# FIREBASE_APP_ID=your-firebase-app-id
# FIREBASE_MESSAGING_SENDER_ID=your-sender-id
# FIREBASE_PROJECT_ID=your-project-id
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

## 🧪 **Testing**

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test suites
flutter test test/unit/
flutter test test/widget/
flutter test test/integration/

# Run golden tests
flutter test test/golden/
```

### Writing Tests

#### Unit Tests
```dart
void main() {
  group('AuthService', () {
    test('should login successfully', () async {
      // Arrange
      final authService = AuthService(mockApiClient, mockStorageService);

      // Act
      final user = await authService.login('test@example.com', 'password');

      // Assert
      expect(user.email, 'test@example.com');
    });
  });
}
```

#### Widget Tests
```dart
void main() {
  testWidgets('should render login form', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
```

## 🌐 **API Integration**

### Making API Calls

```dart
// Get data
final response = await ref.read(apiClientProvider).get('/users/me');
if (response is ApiResponseSuccess) {
  final user = User.fromJson(response.data);
}

// Post data
final response = await ref.read(apiClientProvider).post('/users', data: userData);
```

### Authentication Flow

```dart
// Login
await ref.read(sessionProvider.notifier).login(email, password);

// Check authentication status
final isAuthenticated = ref.watch(isAuthenticatedProvider);

// Get current user
final user = ref.watch(currentUserProvider);
```

## 🎨 **Theming**

### Dynamic Theme Switching

```dart
// Toggle theme
await ref.read(themeProvider.notifier).toggleTheme();

// Set specific theme
await ref.read(themeProvider.notifier).setThemeMode(AppThemeMode.dark);

// Watch current theme
final currentTheme = ref.watch(currentThemeProvider);
```

### Custom Themes

```dart
// Extend existing themes
final customTheme = ref.watch(currentThemeProvider).copyWith(
  primaryColor: Colors.purple,
  textTheme: customTextTheme,
);
```

## 🔒 **Security Features**

### Input Validation

```dart
// Validate user input
final emailError = ValidationHelpers.validateEmail(email);
final passwordError = ValidationHelpers.validatePassword(password);

// Sanitize input
final cleanInput = SecurityService.sanitizeInput(userInput);
```

### Secure Storage

```dart
// Store sensitive data securely
await ref.read(securityServiceProvider).storeToken('auth_token', token);

// Retrieve with automatic decryption
final token = await ref.read(securityServiceProvider).retrieveToken('auth_token');
```

## 📊 **Analytics & Monitoring**

### Logging

```dart
// Log events
logInfo('User logged in', data: {'userId': user.id});
logError('API call failed', data: {'endpoint': '/users'});

// Analytics events
AnalyticsHelpers.logLogin('email');
AnalyticsHelpers.logScreenView('Home');
```

### Performance Monitoring

```dart
// Track operation performance
final stopwatch = Stopwatch()..start();
// ... operation
stopwatch.stop();

AnalyticsHelpers.logPerformance('user_login', stopwatch.elapsed);
```

## 🚀 **Deployment**

### Using Build Scripts

```bash
# Build for production
./scripts/build.sh android production

# Build with testing
./scripts/build.sh all production false false
```

### CI/CD Pipeline

The project includes a complete GitHub Actions workflow that:

- Runs all tests
- Performs code analysis
- Builds for all platforms
- Deploys web to GitHub Pages
- Uploads artifacts

### Environment Setup

1. **Development**: Use `.env` with development API endpoints
2. **Staging**: Create `.env.staging` for staging environment
3. **Production**: Create `.env.production` for production environment

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Ensure all tests pass (`flutter test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Quality

- Follow the existing code style and architecture patterns
- Write tests for all new functionality
- Update documentation for API changes
- Ensure accessibility compliance

## 📚 **Architecture Patterns**

### State Management with Riverpod

```dart
// Provider for simple state
final counterProvider = StateProvider<int>((ref) => 0);

// StateNotifier for complex state
final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier(ref.watch(authServiceProvider));
});

// FutureProvider for async operations
final userProvider = FutureProvider<User>((ref) async {
  return ref.watch(authServiceProvider).getCurrentUser();
});
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<User> updateUser(User user);
  Future<void> deleteUser();
}

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;
  final StorageService _storageService;

  // Implementation
}
```

### Clean Architecture Layers

1. **Presentation Layer**: UI components, pages, widgets
2. **Domain Layer**: Business logic, use cases, entities
3. **Data Layer**: Repository implementations, API clients, storage

## 🔧 **Development Tools**

### Code Generation

```bash
# Generate Riverpod providers
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/providers/session_provider_test.dart
```

### Analysis

```bash
# Analyze code
flutter analyze

# Format code
flutter format .

# Check for outdated packages
flutter pub outdated
```

## 📱 **Platform-Specific Setup**

### Android

1. Configure signing in `android/app/build.gradle`
2. Set up Firebase (if using Firebase services)
3. Configure deep linking in `AndroidManifest.xml`

### iOS

1. Configure signing in Xcode
2. Set up Firebase (if using Firebase services)
3. Configure deep linking in `Info.plist`

### Web

1. Configure Firebase hosting
2. Set up deep linking
3. Configure PWA settings in `web/manifest.json`

## 🆘 **Troubleshooting**

### Common Issues

1. **Build fails**: Run `flutter clean` and `flutter pub get`
2. **Code generation issues**: Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. **Test failures**: Check provider dependencies and mocks
4. **Performance issues**: Enable logging to identify bottlenecks

### Getting Help

- Check the [Issues](../../issues) page for known problems
- Create a new issue with detailed information
- Join our [Discord community](../../discussions) for support

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- [Riverpod](https://riverpod.dev/) for state management
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Dio](https://pub.dev/packages/dio) for HTTP client
- [Hive](https://pub.dev/packages/hive) for local storage
- [Freezed](https://pub.dev/packages/freezed) for code generation

---

**🎉 Happy coding with the ultimate Flutter production boilerplate!**

This boilerplate provides everything you need to build scalable, maintainable, and production-ready Flutter applications with modern architecture patterns and best practices.
