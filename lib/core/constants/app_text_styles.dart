import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Display Styles
  static TextStyle displayLarge = TextStyle(
    fontSize: 57.sp,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25.sp,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 45.sp,
    fontWeight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0.sp,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0.sp,
  );

  // Headline Styles
  static TextStyle headlineLarge = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0.sp,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    height: 1.29,
    letterSpacing: 0.sp,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.sp,
  );

  // Title Styles
  static TextStyle titleLarge = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.sp,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.15.sp,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1.sp,
  );

  // Body Styles
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5.sp,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25.sp,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4.sp,
  );

  // Label Styles
  static TextStyle labelLarge = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1.sp,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5.sp,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5.sp,
  );

  // Custom Styles
  static TextStyle button = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1.sp,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4.sp,
  );

  static TextStyle overline = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 1.5.sp,
  );
}

// Extension for easy theming
extension TextStyleExtensions on TextStyle {
  TextStyle get primary => copyWith(color: Colors.blue[700]);
  TextStyle get secondary => copyWith(color: Colors.grey[600]);
  TextStyle get success => copyWith(color: Colors.green[700]);
  TextStyle get error => copyWith(color: Colors.red[700]);
  TextStyle get warning => copyWith(color: Colors.orange[700]);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get black => copyWith(color: Colors.black);

  TextStyle withOpacity(double opacity) => copyWith(color: color?.withOpacity(opacity));
}
