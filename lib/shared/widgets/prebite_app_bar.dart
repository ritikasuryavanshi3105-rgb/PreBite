import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

/// PreBite Reusable Top App Bar
/// Implements standard Stitch header layout:
/// - Surface background (#FCF9F8)
/// - Clean elevation 0
/// - Inter title-lg (20px, semi-bold)
/// - Consistent action buttons and back navigation
class PreBiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PreBiteAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor = PreBiteColors.surface,
    this.foregroundColor = PreBiteColors.onSurface,
    this.centerTitle = false,
    this.elevation = 0,
    this.hasBottomBorder = true,
  });

  final String title;
  final bool showBackButton;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool centerTitle;
  final double elevation;
  final bool hasBottomBorder;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && showBackButton) {
      final canPop = ModalRoute.of(context)?.canPop ?? false;
      if (canPop) {
        effectiveLeading = IconButton(
          icon: const Icon(Icons.arrow_back),
          color: PreBiteColors.onSurfaceVariant,
          onPressed: () => Navigator.maybePop(context),
          tooltip: 'Back',
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: hasBottomBorder
            ? const Border(
                bottom: BorderSide(
                  color: PreBiteColors.surfaceVariant,
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: AppBar(
        title: Text(
          title,
          style: PreBiteTypography.titleLarge.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: effectiveLeading,
        actions: actions != null
            ? [...actions!, const SizedBox(width: PreBiteSpacing.xs)]
            : null,
        centerTitle: centerTitle,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor,
        elevation: elevation,
        scrolledUnderElevation: 0,
        bottom: bottom,
      ),
    );
  }
}
