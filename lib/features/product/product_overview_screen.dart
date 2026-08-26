import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/shadows.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../shared/widgets/prebite_app_bar.dart';
import '../../shared/widgets/prebite_divider.dart';
import '../../shared/widgets/prebite_score_indicator.dart';
import 'data/mock_product_repository.dart';
import 'models/product_model.dart';
import 'widgets/product_bottom_actions.dart';
import 'widgets/product_tab_bar.dart';

/// PreBite Product Details Overview Screen
/// Route: `/product/:id`
/// Implements the Stitch visual source of truth from `product_details_overview/code.html` & `screen.png`.
class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  late ProductDetailModel _product;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void didUpdateWidget(covariant ProductOverviewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productId != widget.productId) {
      _loadProduct();
    }
  }

  void _loadProduct() {
    _product = MockProductRepository.getProductById(widget.productId);
  }

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go(PreBiteRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreBiteColors.background,
      appBar: PreBiteAppBar(
        title: 'Product Details',
        showBackButton: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: PreBiteColors.onSurfaceVariant,
          onPressed: () => _handleBack(context),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            color: PreBiteColors.onSurfaceVariant,
            tooltip: 'Share',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sharing ${_product.name}...'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited
                  ? PreBiteColors.primary
                  : PreBiteColors.onSurfaceVariant,
            ),
            tooltip: 'Favorite',
            onPressed: () {
              setState(() {
                _isFavorited = !_isFavorited;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFavorited
                        ? 'Added to Favorites!'
                        : 'Removed from Favorites.',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: PreBiteSpacing.marginMobile,
            right: PreBiteSpacing.marginMobile,
            top: PreBiteSpacing.md,
            bottom: PreBiteSpacing.xl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProductImageBox(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildProductHeaderInfo(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildBentoScoreCard(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildVerdictHighlightCard(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  ProductTabBar(
                    currentTab: ProductTab.overview,
                    productId: _product.id,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildWhyItScoresWellSection(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  const PreBiteDivider(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildIngredientSummarySection(context),
                  const SizedBox(height: PreBiteSpacing.lg),
                  const PreBiteDivider(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildNutritionHighlightsSection(context),
                  const SizedBox(height: PreBiteSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProductBottomActions(
        productId: _product.id,
        style: ProductBottomActionStyle.overviewStyle,
      ),
    );
  }

  /// Product Image Card with Category Tag
  Widget _buildProductImageBox() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(PreBiteSpacing.lg),
              child: Image.asset(
                _product.imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 64,
                    color: PreBiteColors.outline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: PreBiteSpacing.md,
            left: PreBiteSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: PreBiteColors.secondaryContainer,
                borderRadius: PreBiteRadius.chip,
              ),
              child: Text(
                _product.category,
                style: PreBiteTypography.labelMedium.copyWith(
                  color: PreBiteColors.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Product Title and Brand/Weight Subtitle
  Widget _buildProductHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _product.name,
          style: PreBiteTypography.headlineLargeMobile.copyWith(
            color: PreBiteColors.onBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.xs),
        Text(
          '${_product.weight} • Brand: ${_product.brand}',
          style: PreBiteTypography.bodyLarge.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Bento PreBite Score Card with Donut Chart and Sub-Score Tiles
  Widget _buildBentoScoreCard() {
    return Container(
      padding: PreBiteSpacing.allLg,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      child: Column(
        children: [
          // Donut score indicator & verdict
          PreBiteScoreRing(
            score: _product.score,
            maxScore: _product.maxScore,
            size: 130,
            strokeWidth: 9.0,
            activeColor: PreBiteColors.primary,
            trackColor: PreBiteColors.surfaceContainer,
          ),
          const SizedBox(height: PreBiteSpacing.md),
          Text(
            _product.scoreLabel,
            style: PreBiteTypography.titleLarge.copyWith(
              color: PreBiteColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: PreBiteSpacing.xs),
          Text(
            _product.scoreSummary,
            textAlign: TextAlign.center,
            style: PreBiteTypography.bodyMedium.copyWith(
              color: PreBiteColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PreBiteSpacing.lg),
          // 3 Metric Sub-Score Tiles
          _buildScoreSubTile(
            icon: Icons.restaurant_outlined,
            label: 'Nutrition',
            score: _product.nutritionScore,
          ),
          const SizedBox(height: PreBiteSpacing.sm),
          _buildScoreSubTile(
            icon: Icons.science_outlined,
            label: 'Ingredients',
            score: _product.ingredientsScore,
          ),
          const SizedBox(height: PreBiteSpacing.sm),
          _buildScoreSubTile(
            icon: Icons.person_outline,
            label: 'Personal Fit',
            score: _product.personalFitScore,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSubTile({
    required IconData icon,
    required String label,
    required double score,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: PreBiteColors.surface,
        borderRadius: PreBiteRadius.button,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: PreBiteColors.primary),
              const SizedBox(width: 10),
              Text(
                label,
                style: PreBiteTypography.bodyMedium.copyWith(
                  color: PreBiteColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            score.toStringAsFixed(1),
            style: PreBiteTypography.bodyMedium.copyWith(
              color: PreBiteColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// Verdict Highlight Card (Tonal Light Green Box)
  Widget _buildVerdictHighlightCard() {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.secondaryContainer, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.check_circle,
              color: PreBiteColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: PreBiteSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _product.verdictTitle,
                  style: PreBiteTypography.bodyLarge.copyWith(
                    color: PreBiteColors.onSecondaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _product.verdictDescription,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Why it scores well" Bullet Points
  Widget _buildWhyItScoresWellSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why it scores well',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        ..._product.whyScoresWell.map(
          (reason) => Padding(
            padding: const EdgeInsets.only(bottom: PreBiteSpacing.sm),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: PreBiteColors.primary,
                  size: 20,
                ),
                const SizedBox(width: PreBiteSpacing.md),
                Expanded(
                  child: Text(
                    reason,
                    style: PreBiteTypography.bodyMedium.copyWith(
                      color: PreBiteColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Ingredient Summary Tag Cloud
  Widget _buildIngredientSummarySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredient Summary',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _product.ingredientSummary.map((item) {
            Color dotColor;
            switch (item.level) {
              case HealthLevel.good:
              case HealthLevel.excellent:
                dotColor = PreBiteColors.primary;
                break;
              case HealthLevel.neutral:
              case HealthLevel.moderate:
                dotColor = PreBiteColors.warning;
                break;
              case HealthLevel.concern:
                dotColor = PreBiteColors.error;
                break;
              case HealthLevel.low:
                dotColor = PreBiteColors.primary;
                break;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: PreBiteColors.surface,
                borderRadius: PreBiteRadius.chip,
                border: Border.all(
                  color: PreBiteColors.surfaceVariant,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.name,
                    style: PreBiteTypography.bodyMedium.copyWith(
                      color: PreBiteColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        InkWell(
          onTap: () =>
              context.go(PreBiteRoutes.productIngredientsPath(_product.id)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Ingredients',
                style: PreBiteTypography.button.copyWith(
                  color: PreBiteColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward,
                color: PreBiteColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Nutrition Highlights Grid
  Widget _buildNutritionHighlightsSection(BuildContext context) {
    final highlights = [
      {'label': 'Calories', 'value': '61 kcal'},
      {'label': 'Protein', 'value': '3.1 g'},
      {'label': 'Fat', 'value': '3.0 g'},
      {'label': 'Total Sugar', 'value': '4.5 g'},
      {'label': 'Sodium', 'value': '45 mg'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Nutrition Highlights ',
            style: PreBiteTypography.titleLarge.copyWith(
              color: PreBiteColors.onBackground,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: '(per 100g)',
                style: PreBiteTypography.bodyMedium.copyWith(
                  color: PreBiteColors.onSurfaceVariant,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: highlights.map((item) {
            return Container(
              width: 145,
              padding: PreBiteSpacing.allMd,
              decoration: BoxDecoration(
                color: PreBiteColors.surface,
                borderRadius: PreBiteRadius.button,
                border: Border.all(
                  color: PreBiteColors.surfaceVariant,
                  width: 1.0,
                ),
                boxShadow: PreBiteShadows.bloom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['label']!,
                    style: PreBiteTypography.labelMedium.copyWith(
                      color: PreBiteColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['value']!,
                    style: PreBiteTypography.titleLarge.copyWith(
                      color: PreBiteColors.onBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        InkWell(
          onTap: () =>
              context.go(PreBiteRoutes.productNutritionPath(_product.id)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Full Nutrition',
                style: PreBiteTypography.button.copyWith(
                  color: PreBiteColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward,
                color: PreBiteColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
