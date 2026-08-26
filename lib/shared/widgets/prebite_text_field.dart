import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

/// PreBite Reusable Text Field Component
/// Implements DESIGN.md specifications:
/// - 12px corner radius (PreBiteRadius.input)
/// - 1px #E2E7E3 border
/// - 2px Primary Green focus stroke
/// - Inter typography body-md
class PreBiteTextField extends StatelessWidget {
  const PreBiteTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.fillColor = PreBiteColors.surfaceContainerLowest,
    this.borderRadius = PreBiteRadius.input,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final Color fillColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      style: PreBiteTypography.bodyLarge.copyWith(
        color: PreBiteColors.onSurface,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        labelText: labelText,
        hintText: hintText,
        hintStyle: PreBiteTypography.bodyMedium.copyWith(
          color: PreBiteColors.tertiaryContainer,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: PreBiteSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: PreBiteColors.borderSubtle,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: PreBiteColors.borderSubtle,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: PreBiteColors.primaryBrand,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: PreBiteColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: PreBiteColors.error, width: 2.0),
        ),
      ),
    );
  }
}

/// PreBite Reusable Search Bar Component
/// Styled for Quick Search on Home Dashboard, History, and Recommendations screens.
class PreBiteSearchBar extends StatelessWidget {
  const PreBiteSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search products, brands, or ingredients...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onTap,
    this.readOnly = false,
    this.trailing,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.input,
        border: Border.all(color: PreBiteColors.borderSubtle, width: 1.0),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: PreBiteTypography.bodyMedium.copyWith(
          color: PreBiteColors.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: PreBiteTypography.bodyMedium.copyWith(
            color: PreBiteColors.tertiaryContainer,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: PreBiteColors.onSurfaceVariant,
            size: 20,
          ),
          suffixIcon:
              trailing ??
              (controller != null && controller!.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        controller!.clear();
                        onClear?.call();
                        onChanged?.call('');
                      },
                    )
                  : null),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: PreBiteSpacing.md,
            vertical: 14.0,
          ),
        ),
      ),
    );
  }
}
