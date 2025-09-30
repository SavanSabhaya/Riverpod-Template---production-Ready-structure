import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

class ThemeState {
  final AppThemeMode mode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final bool isLoading;

  const ThemeState({
    required this.mode,
    required this.lightTheme,
    required this.darkTheme,
    this.isLoading = false,
  });

  ThemeData get currentTheme {
    switch (mode) {
      case AppThemeMode.light:
        return lightTheme;
      case AppThemeMode.dark:
        return darkTheme;
      case AppThemeMode.system:
        // This would be determined by MediaQuery platform brightness
        return lightTheme; // Default fallback
    }
  }

  ThemeState copyWith({
    AppThemeMode? mode,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
    bool? isLoading,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  final StorageService _storageService;

  static const String _themeKey = 'app_theme_mode';

  ThemeNotifier(this._storageService) : super(
    ThemeState(
      mode: AppThemeMode.system,
      lightTheme: _createLightTheme(),
      darkTheme: _createDarkTheme(),
    ),
  ) {
    _loadThemeMode();
  }

  static ThemeData _createLightTheme() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: Colors.grey.shade300,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  static ThemeData _createDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      cardColor: Colors.grey.shade800,
      dividerColor: Colors.grey.shade700,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Future<void> _loadThemeMode() async {
    try {
      final savedMode = await _storageService.getString(_themeKey);
      if (savedMode != null) {
        final mode = AppThemeMode.values.firstWhere(
          (e) => e.name == savedMode,
          orElse: () => AppThemeMode.system,
        );
        state = state.copyWith(mode: mode);
      }
    } catch (e) {
      // Use default theme mode
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    try {
      await _storageService.setString(_themeKey, mode.name);
      state = state.copyWith(mode: mode);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state.mode == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    await setThemeMode(newMode);
  }

  AppThemeMode get currentMode => state.mode;
  ThemeData get currentTheme => state.currentTheme;
}

// Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return ThemeNotifier(storageService);
});

// Convenience providers
final themeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(themeProvider).mode;
});

final currentThemeProvider = Provider<ThemeData>((ref) {
  return ref.watch(themeProvider).currentTheme;
});
