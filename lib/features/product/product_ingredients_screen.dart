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

/// PreBite Product Details Ingredients Screen
/// Route: `/product/:id/ingredients`
/// Implements the Stitch visual source of truth from `product_details_ingredients/code.html` & `screen.png`.
class ProductIngredientsScreen extends StatefulWidget {
  const ProductIngredientsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductIngredientsScreen> createState() =>
      _ProductIngredientsScreenState();
}

class _ProductIngredientsScreenState extends State<ProductIngredientsScreen> {
  late ProductDetailModel _product;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void didUpdateWidget(covariant ProductIngredientsScreen oldWidget) {
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
                  content: Text('Sharing ${_product.name} ingredients...'),
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
                  ProductSummaryHeader(product: _product, showWeight: false),
                  const SizedBox(height: PreBiteSpacing.sm),
                  ProductTabBar(
                    currentTab: ProductTab.ingredients,
                    productId: _product.id,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildAnalysisOverviewSection(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildForYouCard(),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildAllergenInfoCard(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildDetailedBreakdownSection(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildFooterDisclaimer(),
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
      ),
    );
  }

  /// Ingredient Analysis Overview & Progress Bar
  Widget _buildAnalysisOverviewSection() {
    final goodRatio = _product.ingredientCount > 0
        ? _product.goodIngredientCount / _product.ingredientCount
        : 1.0;
    final neutralRatio = _product.ingredientCount > 0
        ? _product.neutralIngredientCount / _product.ingredientCount
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredient Analysis',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Understand what\'s inside this product and how it impacts your health.',
          style: PreBiteTypography.bodyMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        Container(
          padding: PreBiteSpacing.allMd,
          decoration: BoxDecoration(
            color: PreBiteColors.surfaceContainerLowest,
            borderRadius: PreBiteRadius.card,
            border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
            boxShadow: PreBiteShadows.bloom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${_product.ingredientCount}',
                  style: PreBiteTypography.headlineMedium.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: ' Ingredients analyzed',
                      style: PreBiteTypography.bodyMedium.copyWith(
                        color: PreBiteColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: PreBiteSpacing.md),
              // Progress Bar
              ClipRRect(
                borderRadius: PreBiteRadius.full,
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      Expanded(
                        flex: (goodRatio * 100).toInt(),
                        child: Container(color: PreBiteColors.primary),
                      ),
                      if (neutralRatio > 0)
                        Expanded(
                          flex: (neutralRatio * 100).toInt(),
                          child: Container(color: const Color(0xFFFBBF24)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: PreBiteSpacing.md),
              const Divider(color: PreBiteColors.surfaceVariant, height: 1),
              const SizedBox(height: PreBiteSpacing.md),
              // Legend
              Row(
                children: [
                  _buildLegendItem(
                    color: PreBiteColors.primary,
                    label: '${_product.goodIngredientCount} Good',
                  ),
                  const SizedBox(width: PreBiteSpacing.lg),
                  _buildLegendItem(
                    color: const Color(0xFFFBBF24),
                    label: '${_product.neutralIngredientCount} Neutral',
                  ),
                  const SizedBox(width: PreBiteSpacing.lg),
                  Opacity(
                    opacity: 0.5,
                    child: _buildLegendItem(
                      color: PreBiteColors.error,
                      label: '${_product.concernIngredientCount} Concern',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: PreBiteTypography.labelMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// "For You" Dietary Fit Card
  Widget _buildForYouCard() {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.primaryContainer.withValues(alpha: 0.1),
        borderRadius: PreBiteRadius.card,
        border: Border.all(
          color: PreBiteColors.primary.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: PreBiteColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety,
              color: PreBiteColors.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: PreBiteSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'For You',
                  style: PreBiteTypography.button.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _product.forYouMessage,
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

  /// Allergen Info Card
  Widget _buildAllergenInfoCard() {
    return Container(
      padding: PreBiteSpacing.allMd,
      decoration: BoxDecoration(
        color: PreBiteColors.errorContainer.withValues(alpha: 0.2),
        borderRadius: PreBiteRadius.card,
        border: Border.all(
          color: PreBiteColors.error.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: PreBiteColors.error, size: 24),
          const SizedBox(width: PreBiteSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ALLERGEN INFORMATION',
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _product.allergenInfo,
                  style: PreBiteTypography.button.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Detailed Breakdown Cards for Each Ingredient
  Widget _buildDetailedBreakdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Breakdown',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.md),
        ..._product.detailedIngredients.map((ingredient) {
          Color badgeBg;
          Color badgeFg;
          IconData badgeIcon;

          switch (ingredient.level) {
            case HealthLevel.good:
              badgeBg = PreBiteColors.primary.withValues(alpha: 0.1);
              badgeFg = PreBiteColors.primary;
              badgeIcon = Icons.check_circle;
              break;
            case HealthLevel.excellent:
              badgeBg = PreBiteColors.primary.withValues(alpha: 0.1);
              badgeFg = PreBiteColors.primary;
              badgeIcon = Icons.star;
              break;
            case HealthLevel.neutral:
            case HealthLevel.moderate:
              badgeBg = const Color(0xFFFEF3C7);
              badgeFg = const Color(0xFFB45309);
              badgeIcon = Icons.remove;
              break;
            case HealthLevel.concern:
              badgeBg = PreBiteColors.errorContainer;
              badgeFg = PreBiteColors.error;
              badgeIcon = Icons.warning_amber_rounded;
              break;
            case HealthLevel.low:
              badgeBg = PreBiteColors.primary.withValues(alpha: 0.1);
              badgeFg = PreBiteColors.primary;
              badgeIcon = Icons.check_circle;
              break;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: PreBiteSpacing.md),
            padding: PreBiteSpacing.allMd,
            decoration: BoxDecoration(
              color: PreBiteColors.surfaceContainerLowest,
              borderRadius: PreBiteRadius.card,
              border: Border.all(
                color: PreBiteColors.surfaceVariant,
                width: 1.0,
              ),
              boxShadow: PreBiteShadows.bloom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon, name, badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: badgeBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ingredient.iconData,
                        color: badgeFg,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: PreBiteSpacing.md),
                    Expanded(
                      child: Text(
                        ingredient.name,
                        style: PreBiteTypography.titleLarge.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: PreBiteSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: PreBiteRadius.chip,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(badgeIcon, size: 14, color: badgeFg),
                          const SizedBox(width: 4),
                          Text(
                            ingredient.statusLabel,
                            style: PreBiteTypography.labelMedium.copyWith(
                              color: badgeFg,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PreBiteSpacing.md),
                Text(
                  ingredient.description,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.md),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'More research data for ${ingredient.name}...',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Learn More',
                        style: PreBiteTypography.button.copyWith(
                          color: PreBiteColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right,
                        color: PreBiteColors.primary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// Footer Disclaimer
  Widget _buildFooterDisclaimer() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PreBiteSpacing.md,
        vertical: PreBiteSpacing.sm,
      ),
      child: Text(
        'Information provided is for educational purposes and should not replace professional medical advice. Always consult a healthcare provider for personalized dietary recommendations.',
        textAlign: TextAlign.center,
        style: PreBiteTypography.labelMedium.copyWith(
          color: PreBiteColors.onSurfaceVariant.withValues(alpha: 0.7),
          height: 1.4,
        ),
      ),
    );
  }
}
