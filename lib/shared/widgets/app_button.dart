import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

enum AppButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isDisabled && !isLoading;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getButtonStyle(),
        child: _buildChild(),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    final baseStyle = ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      elevation: elevation ?? _getDefaultElevation(),
      padding: padding ?? _getDefaultPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      ),
      minimumSize: Size(0, _getMinHeight()),
    );

    switch (type) {
      case AppButtonType.outline:
        return baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(_getTextColor()),
          side: MaterialStateProperty.all(
            BorderSide(color: AppColors.primary, width: 1.5),
          ),
        );
      case AppButtonType.text:
        return baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          foregroundColor: MaterialStateProperty.all(_getTextColor()),
        );
      default:
        return baseStyle;
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
            ),
          ),
          const SizedBox(width: 8),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: 8),
        ],
        Text(text, style: _getTextStyle()),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          trailingIcon!,
        ],
      ],
    );
  }

  Color? _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor;

    if (!isDisabled && !isLoading) {
      switch (type) {
        case AppButtonType.primary:
          return AppColors.primary;
        case AppButtonType.secondary:
          return AppColors.secondary;
        case AppButtonType.danger:
          return AppColors.error;
        case AppButtonType.outline:
        case AppButtonType.text:
          return Colors.transparent;
      }
    }

    return AppColors.grey300;
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;

    if (!isDisabled && !isLoading) {
      switch (type) {
        case AppButtonType.primary:
        case AppButtonType.secondary:
        case AppButtonType.danger:
          return AppColors.white;
        case AppButtonType.outline:
        case AppButtonType.text:
          return AppColors.primary;
      }
    }

    return AppColors.grey500;
  }

  TextStyle _getTextStyle() {
    final baseStyle = AppTextStyles.button.copyWith(
      color: _getTextColor(),
      fontWeight: FontWeight.w600,
    );

    switch (size) {
      case AppButtonSize.small:
        return baseStyle.copyWith(fontSize: 12);
      case AppButtonSize.large:
        return baseStyle.copyWith(fontSize: 16);
      default:
        return baseStyle;
    }
  }

  double _getDefaultElevation() {
    switch (type) {
      case AppButtonType.text:
        return 0;
      default:
        return isDisabled || isLoading ? 0 : 2;
    }
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      default:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return 6;
      case AppButtonSize.large:
        return 12;
      default:
        return 8;
    }
  }

  double _getMinHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.large:
        return 56;
      default:
        return 44;
    }
  }
}
