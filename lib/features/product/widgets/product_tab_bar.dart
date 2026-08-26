import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

enum ProductTab { overview, ingredients, nutrition, more }

/// Navigation tabs across Product Details: Overview | Ingredients | Nutrition | More
class ProductTabBar extends StatelessWidget {
  const ProductTabBar({
    super.key,
    required this.currentTab,
    required this.productId,
  });

  final ProductTab currentTab;
  final String productId;

  void _onTabSelected(BuildContext context, ProductTab tab) {
    if (tab == currentTab) return;

    switch (tab) {
      case ProductTab.overview:
        context.go(PreBiteRoutes.productOverviewPath(productId));
        break;
      case ProductTab.ingredients:
        context.go(PreBiteRoutes.productIngredientsPath(productId));
        break;
      case ProductTab.nutrition:
        context.go(PreBiteRoutes.productNutritionPath(productId));
        break;
      case ProductTab.more:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Additional product insights coming soon!'),
            duration: Duration(seconds: 1),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(color: PreBiteColors.surfaceVariant, width: 1.0),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildTab(context, 'Overview', ProductTab.overview),
            _buildTab(context, 'Ingredients', ProductTab.ingredients),
            _buildTab(context, 'Nutrition', ProductTab.nutrition),
            _buildTab(context, 'More', ProductTab.more),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title, ProductTab tab) {
    final isSelected = tab == currentTab;

    return InkWell(
      onTap: () => _onTabSelected(context, tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: PreBiteColors.primary, width: 2.5),
                )
              : null,
        ),
        child: Text(
          title,
          style: PreBiteTypography.button.copyWith(
            color: isSelected
                ? PreBiteColors.primary
                : PreBiteColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
