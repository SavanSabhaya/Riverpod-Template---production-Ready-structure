import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccessibilityHelper {
  // Font scaling helpers
  static double getFontScale(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  static bool isLargeFont(BuildContext context) {
    return getFontScale(context) > 1.2;
  }

  static bool isExtraLargeFont(BuildContext context) {
    return getFontScale(context) > 1.5;
  }

  // Screen reader helpers
  static bool isScreenReaderActive(BuildContext context) {
    // This would integrate with accessibility services
    // For demo purposes, return false
    return false;
  }

  static void announceToScreenReader(String message, {bool interrupt = false}) {
    // This would integrate with accessibility services
    // Example: SemanticsService.announce(message, TextDirection.ltr);
  }

  // Focus management
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // Semantic helpers
  static Widget semanticLabel(Widget child, String label) {
    return Semantics(
      label: label,
      child: child,
    );
  }

  static Widget semanticButton(Widget child, String label, {VoidCallback? onTap}) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }

  static Widget semanticHeading(Widget child, String label, {int level = 1}) {
    return Semantics(
      label: label,
      header: true,
      child: child,
    );
  }

  // High contrast mode helpers
  static bool isHighContrastMode(BuildContext context) {
    // This would check system accessibility settings
    return false;
  }

  static Color getAccessibleColor(Color color, Color background) {
    // Ensure sufficient contrast ratio (WCAG AA: 4.5:1)
    const minContrastRatio = 4.5;

    final contrastRatio = _calculateContrastRatio(color, background);

    if (contrastRatio >= minContrastRatio) {
      return color;
    }

    // Return a color that meets contrast requirements
    return _getHighContrastColor(color, background);
  }

  static double _calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = _getRelativeLuminance(color1);
    final luminance2 = _getRelativeLuminance(color2);

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 < luminance2 ? luminance1 : luminance2;

    return (lighter + 0.05) / (darker + 0.05);
  }

  static double _getRelativeLuminance(Color color) {
    final r = _linearizeColorComponent(color.red / 255.0);
    final g = _linearizeColorComponent(color.green / 255.0);
    final b = _linearizeColorComponent(color.blue / 255.0);

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearizeColorComponent(double component) {
    return component <= 0.03928
        ? component / 12.92
        : _gammaCorrection(component);
  }

  static double _gammaCorrection(double component) {
    return pow(component, 2.4).toDouble();
  }

  static Color _getHighContrastColor(Color color, Color background) {
    // Simple contrast enhancement - in a real app, you'd use a more sophisticated algorithm
    final brightness = color.computeLuminance();
    final backgroundBrightness = background.computeLuminance();

    if (backgroundBrightness > 0.5) {
      // Dark background, return lighter color
      return color.withOpacity(0.9);
    } else {
      // Light background, return darker color
      return color.withOpacity(0.8);
    }
  }

  // Touch target helpers
  static bool isTouchTargetLargeEnough(Size size) {
    // WCAG recommends minimum 44x44 points for touch targets
    const minSize = 44.0;
    return size.width >= minSize && size.height >= minSize;
  }

  static EdgeInsets getMinimumTouchTargetPadding(Size currentSize) {
    const minSize = 44.0;
    final horizontalPadding = (minSize - currentSize.width) / 2;
    final verticalPadding = (minSize - currentSize.height) / 2;

    return EdgeInsets.symmetric(
      horizontal: horizontalPadding > 0 ? horizontalPadding : 0,
      vertical: verticalPadding > 0 ? verticalPadding : 0,
    );
  }

  // Animation helpers for accessibility
  static Duration getAccessibleAnimationDuration(Duration originalDuration) {
    // Reduce animation speed for users who prefer reduced motion
    // This would check system accessibility settings
    return originalDuration;
  }

  static bool prefersReducedMotion(BuildContext context) {
    // This would check system accessibility settings
    return false;
  }

  // Keyboard navigation helpers
  static void handleKeyboardNavigation(
    RawKeyEvent event,
    Map<LogicalKeyboardKey, VoidCallback> keyMap,
  ) {
    if (event is RawKeyDownEvent) {
      final callback = keyMap[event.logicalKey];
      callback?.call();
    }
  }

  // Error announcement helpers
  static void announceError(String errorMessage) {
    announceToScreenReader('Error: $errorMessage');
  }

  static void announceSuccess(String successMessage) {
    announceToScreenReader('Success: $successMessage');
  }

  static void announceNavigation(String location) {
    announceToScreenReader('Navigated to $location');
  }
}

// Accessibility widgets
class AccessibleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String label;
  final String? hint;
  final bool autofocus;
  final FocusNode? focusNode;

  const AccessibleButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.label,
    this.hint,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      enabled: onPressed != null,
      child: ElevatedButton(
        onPressed: onPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        child: child,
      ),
    );
  }
}

class AccessibleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;

  const AccessibleTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      textField: true,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        focusNode: focusNode,
      ),
    );
  }
}

class AccessibleCard extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback? onTap;

  const AccessibleCard({
    super.key,
    required this.child,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}

// Responsive design helpers
class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    final width = getScreenWidth(context);

    if (width < 600) {
      return const EdgeInsets.all(16);
    } else if (width < 1200) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = getScreenWidth(context);

    if (width < 600) {
      return baseSize * 0.9;
    } else if (width < 1200) {
      return baseSize;
    } else {
      return baseSize * 1.1;
    }
  }
}
