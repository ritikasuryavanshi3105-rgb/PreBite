import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/product_model.dart';

/// Compact Product Summary Header used on Ingredients and Nutrition tabs
/// Matches Stitch `product_details_ingredients/code.html` and `product_details_nutrition/code.html`.
class ProductSummaryHeader extends StatelessWidget {
  const ProductSummaryHeader({
    super.key,
    required this.product,
    this.showWeight = true,
  });

  final ProductDetailModel product;
  final bool showWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image Thumbnail
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: PreBiteColors.surfaceContainerLowest,
              borderRadius: PreBiteRadius.md,
              border: Border.all(
                color: PreBiteColors.surfaceVariant,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(PreBiteSpacing.xs),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              product.imageAsset,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: PreBiteColors.outline,
                ),
              ),
            ),
          ),
          const SizedBox(width: PreBiteSpacing.md),
          // Info Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.brand.toUpperCase(),
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.name,
                  style: PreBiteTypography.titleLarge.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (showWeight) ...[
                  const SizedBox(height: 2),
                  Text(
                    product.weight,
                    style: PreBiteTypography.bodyMedium.copyWith(
                      color: PreBiteColors.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: PreBiteSpacing.xs),
                // Score Badge Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: PreBiteColors.primaryContainer,
                        borderRadius: PreBiteRadius.chip,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 14,
                            color: PreBiteColors.onPrimaryContainer,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.score.toStringAsFixed(1),
                            style: PreBiteTypography.labelMedium.copyWith(
                              color: PreBiteColors.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: PreBiteSpacing.sm),
                    Text(
                      product.scoreLabel,
                      style: PreBiteTypography.bodyMedium.copyWith(
                        color: PreBiteColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
