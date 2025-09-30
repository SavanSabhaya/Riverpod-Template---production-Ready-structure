class AppConstants {
  // App Info
  static const String appName = 'Flutter Boilerplate';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API Constants
  static const int apiTimeout = 30000; // milliseconds
  static const int maxRetries = 3;
  static const String apiVersion = 'v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Duration
  static const Duration debounceDuration = Duration(milliseconds: 300);

  // Image Quality
  static const int imageQuality = 85;
  static const int thumbnailQuality = 70;

  // File Size Limits (in bytes)
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB

  // Regular Expressions
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  // URL Patterns
  static const String imageUrlPattern = r'\.(jpeg|jpg|gif|png|bmp|webp|svg)$';
  static const String videoUrlPattern = r'\.(mp4|avi|mov|wmv|flv|webm|mkv)$';

  // Error Messages
  static const String networkError = 'Network error occurred. Please check your connection.';
  static const String serverError = 'Server error occurred. Please try again later.';
  static const String unauthorizedError = 'Unauthorized access. Please login again.';
  static const String sessionExpired = 'Your session has expired. Please login again.';
  static const String unknownError = 'An unknown error occurred. Please try again.';

  // Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String logoutSuccess = 'Logout successful!';
  static const String profileUpdateSuccess = 'Profile updated successfully!';
  static const String passwordChangeSuccess = 'Password changed successfully!';

  // Validation Messages
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Please enter a valid email address';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 8 characters long';
  static const String passwordWeak = 'Password must contain uppercase, lowercase, and number';
  static const String phoneRequired = 'Phone number is required';
  static const String phoneInvalid = 'Please enter a valid phone number';

  // Empty States
  static const String noData = 'No data available';
  static const String noResults = 'No results found';
  static const String noInternet = 'No internet connection';
  static const String somethingWentWrong = 'Something went wrong';

  // Button Labels
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String remove = 'Remove';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String finish = 'Finish';
  static const String skip = 'Skip';

  // Accessibility Labels
  static const String loading = 'Loading...';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String warning = 'Warning';
  static const String info = 'Information';
}
