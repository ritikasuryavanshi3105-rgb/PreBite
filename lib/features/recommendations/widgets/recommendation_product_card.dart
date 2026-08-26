import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/recommendation_model.dart';

/// Recommended Product Card matching Stitch layout and design tokens
class RecommendationProductCard extends StatefulWidget {
  const RecommendationProductCard({
    super.key,
    required this.product,
    this.onCompareTap,
  });

  final RecommendedProductItem product;
  final VoidCallback? onCompareTap;

  @override
  State<RecommendationProductCard> createState() =>
      _RecommendationProductCardState();
}

class _RecommendationProductCardState extends State<RecommendationProductCard> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited
              ? 'Added ${widget.product.name} to Favorites!'
              : 'Removed from Favorites.',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surface,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header Box with Score and Favorite Overlay
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: PreBiteColors.surfaceContainer,
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(PreBiteSpacing.sm),
                    child: Image.asset(
                      product.imageAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 48,
                              color: PreBiteColors.outline,
                            ),
                          ),
                    ),
                  ),
                ),
                // Score Pill (Top-Left)
                Positioned(
                  top: PreBiteSpacing.sm,
                  left: PreBiteSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: product.isOccasional
                          ? PreBiteColors.tertiary
                          : PreBiteColors.primary,
                      borderRadius: PreBiteRadius.chip,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          product.isOccasional
                              ? Icons.info_outline
                              : Icons.verified_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.score.toStringAsFixed(1),
                          style: PreBiteTypography.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite Button (Top-Right)
                Positioned(
                  top: PreBiteSpacing.sm,
                  right: PreBiteSpacing.sm,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: PreBiteColors.surface.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: _isFavorited
                            ? PreBiteColors.error
                            : PreBiteColors.outline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Area
          Padding(
            padding: PreBiteSpacing.allMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
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
                const SizedBox(height: 6),
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: product.isOccasional
                        ? PreBiteColors.surfaceVariant
                        : PreBiteColors.secondaryContainer,
                    borderRadius: PreBiteRadius.sm,
                    border: product.isOccasional
                        ? Border.all(
                            color: PreBiteColors.outlineVariant.withValues(
                              alpha: 0.5,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    product.badgeLabel,
                    style: PreBiteTypography.labelMedium.copyWith(
                      color: product.isOccasional
                          ? PreBiteColors.onSurfaceVariant
                          : PreBiteColors.onSecondaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.md),
                // Highlights
                ...product.highlights.map(
                  (h) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(
                          h.icon ??
                              (h.isPositive
                                  ? Icons.check_circle
                                  : Icons.info_outline),
                          size: 16,
                          color: h.isPositive
                              ? PreBiteColors.primary
                              : PreBiteColors.tertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          h.text,
                          style: PreBiteTypography.bodyMedium.copyWith(
                            color: PreBiteColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.sm),
                // Bottom Action Buttons
                Container(
                  padding: const EdgeInsets.only(top: PreBiteSpacing.sm),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: PreBiteColors.surfaceVariant,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // + Compare
                      Expanded(
                        child: OutlinedButton(
                          onPressed:
                              widget.onCompareTap ??
                              () => context.go(PreBiteRoutes.productComparison),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: PreBiteColors.primary,
                            side: const BorderSide(
                              color: PreBiteColors.primary,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: PreBiteRadius.button,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            '+ Compare',
                            style: PreBiteTypography.button.copyWith(
                              color: PreBiteColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: PreBiteSpacing.sm),
                      // View Details
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.go(
                            PreBiteRoutes.productOverviewPath(product.id),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PreBiteColors.primary,
                            foregroundColor: PreBiteColors.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: PreBiteRadius.button,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 0,
                          ),
                          child: Text(
                            'View Details',
                            style: PreBiteTypography.button.copyWith(
                              color: PreBiteColors.onPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
