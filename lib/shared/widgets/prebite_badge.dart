import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

enum PreBiteBadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  neutral,
  outline,
}

/// PreBite Reusable Badge / Chip Component
/// Implements DESIGN.md specifications:
/// - Light Green / secondary-container background with Primary Green text
/// - `label-md` typography (12px, medium, 0.05em tracking)
/// - Fully rounded pill shape (PreBiteRadius.chip / full)
class PreBiteBadge extends StatelessWidget {
  const PreBiteBadge({
    super.key,
    required this.label,
    this.variant = PreBiteBadgeVariant.secondary,
    this.icon,
    this.onTap,
    this.onDelete,
    this.isSelected = false,
    this.backgroundColor,
    this.textColor,
    this.padding = PreBiteSpacing.chipPadding,
  });

  final String label;
  final PreBiteBadgeVariant variant;
  final Widget? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case PreBiteBadgeVariant.primary:
        bg = backgroundColor ?? PreBiteColors.primary;
        fg = textColor ?? PreBiteColors.onPrimary;
        break;
      case PreBiteBadgeVariant.secondary:
        bg =
            backgroundColor ??
            (isSelected
                ? PreBiteColors.primary
                : PreBiteColors.secondaryContainer);
        fg =
            textColor ??
            (isSelected
                ? PreBiteColors.onPrimary
                : PreBiteColors.onSecondaryContainer);
        break;
      case PreBiteBadgeVariant.success:
        bg = backgroundColor ?? PreBiteColors.successContainer;
        fg = textColor ?? PreBiteColors.onSuccessContainer;
        break;
      case PreBiteBadgeVariant.warning:
        bg = backgroundColor ?? PreBiteColors.warningContainer;
        fg = textColor ?? PreBiteColors.onWarningContainer;
        break;
      case PreBiteBadgeVariant.error:
        bg = backgroundColor ?? PreBiteColors.errorContainer;
        fg = textColor ?? PreBiteColors.onErrorContainer;
        break;
      case PreBiteBadgeVariant.neutral:
        bg = backgroundColor ?? PreBiteColors.surfaceContainerHigh;
        fg = textColor ?? PreBiteColors.onSurfaceVariant;
        break;
      case PreBiteBadgeVariant.outline:
        bg = backgroundColor ?? Colors.transparent;
        fg = textColor ?? PreBiteColors.onSurfaceVariant;
        borderSide = const BorderSide(
          color: PreBiteColors.borderSubtle,
          width: 1.0,
        );
        break;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(color: fg, size: 14),
            child: icon!,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: PreBiteTypography.labelMedium.copyWith(
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (onDelete != null) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.close, size: 14, color: fg),
          ),
        ],
      ],
    );

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: PreBiteRadius.chip,
        side: borderSide,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: PreBiteRadius.chip,
        child: Padding(padding: padding, child: content),
      ),
    );
  }
}
