import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../shared/widgets/prebite_button.dart';

enum ProductBottomActionStyle {
  // Primary 'Add to Compare' button + secondary heart button (Overview screen)
  overviewStyle,
  // Dual wide buttons: 'Add to Compare' + 'Add to Favorites' with medical disclaimer (Nutrition & Ingredients)
  dualWideStyle,
}

class ProductBottomActions extends StatefulWidget {
  const ProductBottomActions({
    super.key,
    required this.productId,
    this.style = ProductBottomActionStyle.overviewStyle,
    this.showDisclaimer = false,
  });

  final String productId;
  final ProductBottomActionStyle style;
  final bool showDisclaimer;

  @override
  State<ProductBottomActions> createState() => _ProductBottomActionsState();
}

class _ProductBottomActionsState extends State<ProductBottomActions> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited ? 'Added to Favorites!' : 'Removed from Favorites.',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onComparePressed() {
    context.go(PreBiteRoutes.productComparison);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: PreBiteColors.surfaceVariant, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: PreBiteSpacing.marginMobile,
        vertical: PreBiteSpacing.md,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.style == ProductBottomActionStyle.overviewStyle)
              Row(
                children: [
                  Expanded(
                    child: PreBiteButton(
                      text: 'Add to Compare',
                      onPressed: _onComparePressed,
                      variant: PreBiteButtonVariant.primary,
                      size: PreBiteButtonSize.large,
                    ),
                  ),
                  const SizedBox(width: PreBiteSpacing.md),
                  InkWell(
                    onTap: _toggleFavorite,
                    borderRadius: PreBiteRadius.button,
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: PreBiteColors.secondaryContainer,
                        borderRadius: PreBiteRadius.button,
                      ),
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: PreBiteColors.primary,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: _onComparePressed,
                        icon: const Icon(
                          Icons.compare_arrows,
                          color: PreBiteColors.primary,
                          size: 20,
                        ),
                        label: Text(
                          'Add to Compare',
                          style: PreBiteTypography.button.copyWith(
                            color: PreBiteColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: PreBiteColors.outlineVariant,
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: PreBiteRadius.button,
                          ),
                          backgroundColor: PreBiteColors.surface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: PreBiteSpacing.sm),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: PreBiteColors.onPrimary,
                          size: 20,
                        ),
                        label: Text(
                          _isFavorited ? 'Favorited' : 'Add to Favorites',
                          style: PreBiteTypography.button.copyWith(
                            color: PreBiteColors.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PreBiteColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: PreBiteRadius.button,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.showDisclaimer) ...[
              const SizedBox(height: PreBiteSpacing.sm),
              Text(
                'The PreBite score and nutrition analysis are for informational purposes only and do not constitute medical advice. Consult a healthcare professional for personalized dietary recommendations.',
                textAlign: TextAlign.center,
                style: PreBiteTypography.labelMedium.copyWith(
                  fontSize: 10,
                  height: 1.3,
                  color: PreBiteColors.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
