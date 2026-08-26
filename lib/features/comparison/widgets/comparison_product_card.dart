import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/comparison_model.dart';

/// Side-by-side product card for comparison grid
class ComparisonProductCard extends StatelessWidget {
  const ComparisonProductCard({
    super.key,
    required this.product,
    this.onRemove,
  });

  final ComparisonProductItem product;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surface,
        borderRadius: PreBiteRadius.button,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      padding: PreBiteSpacing.allMd,
      child: Stack(
        children: [
          InkWell(
            onTap: () =>
                context.go(PreBiteRoutes.productOverviewPath(product.id)),
            borderRadius: PreBiteRadius.button,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Image Box with Score Overlay
                Container(
                  height: 128,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: PreBiteColors.surfaceContainer,
                    borderRadius: PreBiteRadius.defaultBorderRadius,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(PreBiteSpacing.xs),
                          child: Image.asset(
                            product.imageAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: PreBiteColors.outline,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      // Score Pill Overlay (bottom-left)
                      Positioned(
                        bottom: PreBiteSpacing.sm,
                        left: PreBiteSpacing.sm,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: product.isWinner
                                ? PreBiteColors.primary
                                : PreBiteColors.secondary,
                            borderRadius: PreBiteRadius.sm,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.eco,
                                size: 13,
                                color: PreBiteColors.onPrimary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.score.toStringAsFixed(1),
                                style: PreBiteTypography.labelMedium.copyWith(
                                  color: PreBiteColors.onPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.sm),
                // Brand label
                Text(
                  product.brand.toUpperCase(),
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                // Product Name
                Text(
                  product.name,
                  style: PreBiteTypography.titleLarge.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Weight
                Text(
                  product.weight,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.sm),
                // Choice Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: product.isWinner
                        ? PreBiteColors.secondaryContainer
                        : PreBiteColors.surfaceVariant,
                    borderRadius: PreBiteRadius.chip,
                  ),
                  child: Text(
                    product.badgeLabel,
                    style: PreBiteTypography.labelMedium.copyWith(
                      color: product.isWinner
                          ? PreBiteColors.onSecondaryContainer
                          : PreBiteColors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Close button (top-right)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap:
                  onRemove ??
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed ${product.name} from compare'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: PreBiteColors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
