import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/shadows.dart';
import '../../core/theme/spacing.dart';

/// PreBite Reusable Card Container
/// Implements DESIGN.md specifications:
/// - White background (#FFFFFF / surfaceContainerLowest)
/// - 1px border (#E2E7E3 / borderSubtle)
/// - 16px corner radius (PreBiteRadius.card)
/// - Generous internal padding (24px by default)
/// - Ambient Soft Bloom shadow
class PreBiteCard extends StatelessWidget {
  const PreBiteCard({
    super.key,
    required this.child,
    this.padding = PreBiteSpacing.cardPadding,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = PreBiteColors.surfaceContainerLowest,
    this.borderColor = PreBiteColors.borderSubtle,
    this.borderWidth = 1.0,
    this.borderRadius = PreBiteRadius.card,
    this.hasBloomShadow = true,
    this.customShadows,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final bool hasBloomShadow;
  final List<BoxShadow>? customShadows;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final effectiveShadows =
        customShadows ??
        (hasBloomShadow ? PreBiteShadows.bloom : const <BoxShadow>[]);

    final cardContent = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: borderWidth > 0
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: effectiveShadows,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );

    return cardContent;
  }
}
