import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/shadows.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../shared/widgets/prebite_app_bar.dart';
import 'data/mock_product_repository.dart';
import 'models/product_model.dart';
import 'widgets/product_bottom_actions.dart';
import 'widgets/product_summary_header.dart';
import 'widgets/product_tab_bar.dart';

/// PreBite Product Details Nutrition Screen
/// Route: `/product/:id/nutrition`
/// Implements the Stitch visual source of truth from `product_details_nutrition/code.html` & `screen.png`.
class ProductNutritionScreen extends StatefulWidget {
  const ProductNutritionScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductNutritionScreen> createState() => _ProductNutritionScreenState();
}

class _ProductNutritionScreenState extends State<ProductNutritionScreen> {
  late ProductDetailModel _product;
  bool _isFavorited = false;
  bool _isPerServing = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void didUpdateWidget(covariant ProductNutritionScreen oldWidget) {
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
    final activeTable = _isPerServing
        ? _product.nutritionPerServing
        : _product.nutritionPer100g;

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
                  content: Text('Sharing ${_product.name} nutrition...'),
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
                  ProductSummaryHeader(product: _product, showWeight: true),
                  const SizedBox(height: PreBiteSpacing.sm),
                  ProductTabBar(
                    currentTab: ProductTab.nutrition,
                    productId: _product.id,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildNutritionHeaderSection(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildServingToggle(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildNutritionScoreCard(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildNutritionTable(activeTable),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildNutritionHighlightsSection(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildWhatThisMeansForYouCard(),
                  const SizedBox(height: PreBiteSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProductBottomActions(
        productId: _product.id,
        style: ProductBottomActionStyle.dualWideStyle,
        showDisclaimer: true,
      ),
    );
  }

  /// Nutrition Information Heading
  Widget _buildNutritionHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Information',
          style: PreBiteTypography.headlineMedium.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'See the nutritional values that contribute to the PreBite score.',
          style: PreBiteTypography.bodyMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Serving Size Toggle Button ("Per 100 g" vs "Per Serving")
  Widget _buildServingToggle() {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceVariant,
        borderRadius: PreBiteRadius.button,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (_isPerServing) {
                  setState(() => _isPerServing = false);
                }
              },
              borderRadius: PreBiteRadius.button,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isPerServing
                      ? PreBiteColors.surface
                      : Colors.transparent,
                  borderRadius: PreBiteRadius.button,
                  boxShadow: !_isPerServing ? PreBiteShadows.bloom : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Per 100 g',
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: !_isPerServing
                        ? PreBiteColors.primary
                        : PreBiteColors.onSurfaceVariant,
                    fontWeight: !_isPerServing
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (!_isPerServing) {
                  setState(() => _isPerServing = true);
                }
              },
              borderRadius: PreBiteRadius.button,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isPerServing
                      ? PreBiteColors.surface
                      : Colors.transparent,
                  borderRadius: PreBiteRadius.button,
                  boxShadow: _isPerServing ? PreBiteShadows.bloom : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  _product.servingLabel,
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: _isPerServing
                        ? PreBiteColors.primary
                        : PreBiteColors.onSurfaceVariant,
                    fontWeight: _isPerServing
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Nutrition Score Card
  Widget _buildNutritionScoreCard() {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.secondaryFixed.withValues(alpha: 0.2),
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.secondaryFixedDim, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NUTRITION SCORE',
                style: PreBiteTypography.labelMedium.copyWith(
                  color: PreBiteColors.onPrimaryFixedVariant,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  text: _product.nutritionScore.toStringAsFixed(1),
                  style: PreBiteTypography.headlineMedium.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: ' / 10',
                      style: PreBiteTypography.titleLarge.copyWith(
                        color: PreBiteColors.primaryFixedDim,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: PreBiteColors.surface,
              borderRadius: PreBiteRadius.chip,
              border: Border.all(
                color: PreBiteColors.secondaryFixedDim,
                width: 1.0,
              ),
              boxShadow: PreBiteShadows.bloom,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: PreBiteColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  _product.nutritionScoreLabel,
                  style: PreBiteTypography.button.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Nutrition Table
  Widget _buildNutritionTable(List<NutritionTableItem> rows) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isEven = index.isEven;
          final isLast = index == rows.length - 1;

          return Container(
            padding: EdgeInsets.only(
              left: item.isIndented ? 36.0 : PreBiteSpacing.md,
              right: PreBiteSpacing.md,
              top: 14,
              bottom: 14,
            ),
            decoration: BoxDecoration(
              color: isEven
                  ? PreBiteColors.surfaceContainerLowest
                  : PreBiteColors.surfaceBright,
              border: !isLast
                  ? const Border(
                      bottom: BorderSide(
                        color: PreBiteColors.surfaceVariant,
                        width: 1.0,
                      ),
                    )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: PreBiteTypography.bodyMedium.copyWith(
                        color: item.isIndented
                            ? PreBiteColors.onSurfaceVariant
                            : PreBiteColors.onSurface,
                        fontWeight: item.isIndented
                            ? FontWeight.w400
                            : FontWeight.w600,
                      ),
                    ),
                    if (item.tag != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getTagBgColor(item.tagLevel),
                          borderRadius: PreBiteRadius.sm,
                        ),
                        child: Text(
                          item.tag!.toUpperCase(),
                          style: PreBiteTypography.labelMedium.copyWith(
                            fontSize: 10,
                            color: _getTagFgColor(item.tagLevel),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  item.displayValue,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getTagBgColor(HealthLevel? level) {
    switch (level) {
      case HealthLevel.good:
      case HealthLevel.excellent:
      case HealthLevel.low:
        return PreBiteColors.secondaryFixed;
      case HealthLevel.neutral:
      case HealthLevel.moderate:
        return const Color(0xFFFEF3C7);
      case HealthLevel.concern:
        return PreBiteColors.errorContainer;
      case null:
        return PreBiteColors.surfaceVariant;
    }
  }

  Color _getTagFgColor(HealthLevel? level) {
    switch (level) {
      case HealthLevel.good:
      case HealthLevel.excellent:
      case HealthLevel.low:
        return PreBiteColors.onPrimaryFixedVariant;
      case HealthLevel.neutral:
      case HealthLevel.moderate:
        return const Color(0xFFB45309);
      case HealthLevel.concern:
        return PreBiteColors.error;
      case null:
        return PreBiteColors.onSurfaceVariant;
    }
  }

  /// Nutrition Highlights (2x2 Grid)
  Widget _buildNutritionHighlightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Highlights',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.6,
          ),
          itemCount: _product.nutritionHighlights.length,
          itemBuilder: (context, index) {
            final item = _product.nutritionHighlights[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: PreBiteColors.surfaceContainerLowest,
                borderRadius: PreBiteRadius.button,
                border: Border.all(
                  color: PreBiteColors.surfaceVariant,
                  width: 1.0,
                ),
                boxShadow: PreBiteShadows.bloom,
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: item.isNeutral
                          ? PreBiteColors.surfaceVariant
                          : PreBiteColors.secondaryFixed.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.iconData,
                      size: 18,
                      color: item.isNeutral
                          ? PreBiteColors.onSurfaceVariant
                          : PreBiteColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.label,
                      style: PreBiteTypography.labelMedium.copyWith(
                        color: PreBiteColors.onSurface,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Personalized "What This Means For You" Card
  Widget _buildWhatThisMeansForYouCard() {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.onTertiaryContainer,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: PreBiteColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: PreBiteColors.onPrimary,
              size: 22,
            ),
          ),
          const SizedBox(width: PreBiteSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What This Means For You',
                  style: PreBiteTypography.button.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _product.whatThisMeansForYou,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                    height: 1.4,
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
