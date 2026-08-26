import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

enum PreBiteButtonVariant { primary, secondary, outline, ghost, danger }

enum PreBiteButtonSize {
  small(height: 36.0, horizontalPadding: 12.0),
  medium(height: 48.0, horizontalPadding: 16.0),
  large(height: 54.0, horizontalPadding: 20.0);

  final double height;
  final double horizontalPadding;

  const PreBiteButtonSize({
    required this.height,
    required this.horizontalPadding,
  });
}

/// PreBite Reusable Button Component
/// Implements DESIGN.md specifications:
/// - 12px corner radius
/// - 16px horizontal padding
/// - Primary: Dark Green (#006B32) background + White text
/// - Secondary: Light Green (#EAF7EE / #9FF6B2) + Primary Green text
class PreBiteButton extends StatelessWidget {
  const PreBiteButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = PreBiteButtonVariant.primary,
    this.size = PreBiteButtonSize.medium,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  final String text;
  final VoidCallback? onPressed;
  final PreBiteButtonVariant variant;
  final PreBiteButtonSize size;
  final Widget? icon;
  final bool isFullWidth;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? PreBiteRadius.button;

    Color bg;
    Color fg;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case PreBiteButtonVariant.primary:
        bg = backgroundColor ?? PreBiteColors.primary;
        fg = textColor ?? PreBiteColors.onPrimary;
        break;
      case PreBiteButtonVariant.secondary:
        bg = backgroundColor ?? PreBiteColors.secondaryContainer;
        fg = textColor ?? PreBiteColors.primary;
        break;
      case PreBiteButtonVariant.outline:
        bg = backgroundColor ?? Colors.transparent;
        fg = textColor ?? PreBiteColors.primary;
        borderSide = const BorderSide(
          color: PreBiteColors.borderSubtle,
          width: 1.0,
        );
        break;
      case PreBiteButtonVariant.ghost:
        bg = backgroundColor ?? Colors.transparent;
        fg = textColor ?? PreBiteColors.primary;
        break;
      case PreBiteButtonVariant.danger:
        bg = backgroundColor ?? PreBiteColors.error;
        fg = textColor ?? PreBiteColors.onError;
        break;
    }

    final isInteractive = onPressed != null && !isLoading;
    if (!isInteractive && onPressed == null) {
      bg = PreBiteColors.surfaceContainerHigh;
      fg = PreBiteColors.tertiaryFixedDim;
    }

    Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        else ...[
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 20),
              child: icon!,
            ),
            const SizedBox(width: PreBiteSpacing.sm),
          ],
          Flexible(
            child: Text(
              text,
              style: PreBiteTypography.button.copyWith(
                color: fg,
                fontSize: size == PreBiteButtonSize.small ? 14 : 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: size.height,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: effectiveRadius,
          side: borderSide,
        ),
        child: InkWell(
          onTap: isInteractive ? onPressed : null,
          borderRadius: effectiveRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.horizontalPadding),
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
