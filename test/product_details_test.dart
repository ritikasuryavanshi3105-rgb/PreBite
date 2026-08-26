import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/product/data/mock_product_repository.dart';
import 'package:prebite/features/product/product_ingredients_screen.dart';
import 'package:prebite/features/product/product_nutrition_screen.dart';
import 'package:prebite/features/product/product_overview_screen.dart';
import 'package:prebite/features/product/widgets/product_tab_bar.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PreBite Mock Product Repository', () {
    test('Returns Amul Masti Dahi by default or exact ID match', () {
      final product = MockProductRepository.getProductById('amul-masti-dahi');
      expect(product.name, 'Amul Masti Dahi');
      expect(product.brand, 'Amul');
      expect(product.score, 9.1);
      expect(product.category, 'Dairy / Curd');
      expect(product.ingredientCount, 4);
      expect(product.whyScoresWell.length, 3);
    });

    test('Returns Mother Dairy for mother dairy ID', () {
      final product = MockProductRepository.getProductById('mother-dairy-400');
      expect(product.brand, 'Mother Dairy');
      expect(product.score, 8.4);
    });

    test('Returns Quaker Oats for quaker oats ID', () {
      final product = MockProductRepository.getProductById('quaker-oats-500');
      expect(product.brand, 'Quaker');
      expect(product.score, 8.2);
    });

    test('Returns Hershey syrup for hersheys ID', () {
      final product = MockProductRepository.getProductById(
        'hersheys-syrup-400',
      );
      expect(product.brand, "Hershey's");
      expect(product.score, 6.8);
    });

    test('Returns fallback default for unknown ID', () {
      final product = MockProductRepository.getProductById('unknown-item-123');
      expect(product.name, 'Amul Masti Dahi');
    });
  });

  group('ProductOverviewScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductOverviewScreen(productId: 'amul-masti-dahi'),
        ),
      );
      await tester.pumpAndSettle();

      // Top App Bar & Headers
      expect(find.text('Product Details'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('400g • Brand: Amul'), findsOneWidget);
      expect(find.text('Dairy / Curd'), findsOneWidget);

      // Score Bento
      expect(find.text('Good Choice'), findsOneWidget);
      expect(
        find.text('A healthy everyday option based on your preferences.'),
        findsOneWidget,
      );
      expect(find.text('Nutrition'), findsWidgets);
      expect(find.text('Ingredients'), findsWidgets);
      expect(find.text('Personal Fit'), findsOneWidget);
      expect(find.text('9.1'), findsWidgets);

      // Verdict card
      expect(find.text('Good Choice For You'), findsOneWidget);

      // Tab bar
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Nutrition'), findsWidgets);
      expect(find.text('More'), findsOneWidget);

      // Overview sections
      expect(find.text('Why it scores well'), findsOneWidget);
      expect(find.text('Low Added Sugar'), findsOneWidget);
      expect(find.text('Good Protein'), findsOneWidget);
      expect(find.text('Simple Ingredients'), findsOneWidget);

      // Ingredient Summary
      expect(find.text('Ingredient Summary'), findsOneWidget);
      expect(find.text('Milk Solids'), findsOneWidget);
      expect(find.text('Live Cultures'), findsOneWidget);
      expect(find.text('View All Ingredients'), findsOneWidget);

      // Nutrition Highlights
      expect(find.text('View Full Nutrition'), findsOneWidget);

      // Bottom actions
      expect(find.text('Add to Compare'), findsOneWidget);
    });

    testWidgets('Favorite button toggles state and shows snackbar', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductOverviewScreen(productId: 'amul-masti-dahi'),
        ),
      );
      await tester.pumpAndSettle();

      final favoriteBtn = find.byIcon(Icons.favorite_border).first;
      await tester.tap(favoriteBtn);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Favorites!'), findsOneWidget);
    });
  });

  group('ProductIngredientsScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductIngredientsScreen(productId: 'amul-masti-dahi'),
        ),
      );
      await tester.pumpAndSettle();

      // Top header & summary
      expect(find.text('Product Details'), findsOneWidget);
      expect(find.text('AMUL'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('Good Choice'), findsOneWidget);

      // Ingredient Analysis Overview
      expect(find.text('Ingredient Analysis'), findsOneWidget);
      expect(find.text('3 Good'), findsOneWidget);
      expect(find.text('1 Neutral'), findsOneWidget);
      expect(find.text('0 Concern'), findsOneWidget);

      // For You & Allergen cards
      expect(find.text('For You'), findsOneWidget);
      expect(find.text('ALLERGEN INFORMATION'), findsOneWidget);
      expect(find.text('Contains: Milk'), findsOneWidget);

      // Detailed breakdown cards
      expect(find.text('Detailed Breakdown'), findsOneWidget);
      expect(find.text('Milk'), findsWidgets);
      expect(find.text('Milk Solids'), findsOneWidget);
      expect(find.text('Live Cultures'), findsOneWidget);
      expect(find.text('Sugar (Naturally Occurring)'), findsOneWidget);
      expect(find.text('Learn More'), findsWidgets);

      // Medical disclaimer
      expect(
        find.textContaining('Information provided is for educational purposes'),
        findsOneWidget,
      );

      // Bottom actions
      expect(find.text('Add to Compare'), findsOneWidget);
      expect(find.text('Add to Favorites'), findsOneWidget);
    });
  });

  group('ProductNutritionScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductNutritionScreen(productId: 'amul-masti-dahi'),
        ),
      );
      await tester.pumpAndSettle();

      // Top header & summary
      expect(find.text('Product Details'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('400g'), findsOneWidget);

      // Nutrition Info & Score
      expect(find.text('Nutrition Information'), findsOneWidget);
      expect(find.text('NUTRITION SCORE'), findsOneWidget);
      expect(find.text('Excellent'), findsWidgets);

      // Serving Toggle
      expect(find.text('Per 100 g'), findsOneWidget);
      expect(find.text('Per Serving (200g)'), findsOneWidget);

      // Table initial 100g values
      expect(find.text('Energy'), findsOneWidget);
      expect(find.text('61 kcal'), findsOneWidget);
      expect(find.text('3.1 g'), findsOneWidget);
      expect(find.text('Added Sugar'), findsOneWidget);

      // Nutrition Highlights
      expect(find.text('Nutrition Highlights'), findsOneWidget);
      expect(find.text('Low Added Sugar'), findsOneWidget);
      expect(find.text('Good Protein'), findsOneWidget);
      expect(find.text('Moderate Fat'), findsOneWidget);
      expect(find.text('Source of Calcium'), findsOneWidget);

      // Personalized card
      expect(find.text('What This Means For You'), findsOneWidget);

      // Disclaimer in footer
      expect(
        find.textContaining(
          'The PreBite score and nutrition analysis are for informational purposes',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Tapping Serving Toggle switches nutritional values', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductNutritionScreen(productId: 'amul-masti-dahi'),
        ),
      );
      await tester.pumpAndSettle();

      // 100g initial value
      expect(find.text('61 kcal'), findsOneWidget);
      expect(find.text('3.1 g'), findsOneWidget);

      // Tap 'Per Serving (200g)'
      await tester.tap(find.text('Per Serving (200g)'));
      await tester.pumpAndSettle();

      // 200g updated values
      expect(find.text('122 kcal'), findsOneWidget);
      expect(find.text('6.2 g'), findsOneWidget);

      // Tap back to 'Per 100 g'
      await tester.tap(find.text('Per 100 g'));
      await tester.pumpAndSettle();

      // Values restored
      expect(find.text('61 kcal'), findsOneWidget);
      expect(find.text('3.1 g'), findsOneWidget);
    });
  });

  group('Full Product Details Router Flow', () {
    testWidgets('Navigates between Overview, Ingredients, and Nutrition tabs', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );

      // 1. Navigate to Overview
      preBiteRouter.go(PreBiteRoutes.productOverviewPath('amul-masti-dahi'));
      await tester.pumpAndSettle();
      expect(find.text('Why it scores well'), findsOneWidget);

      // 2. Tap Ingredients tab in ProductTabBar
      final ingredientsTab = find.descendant(
        of: find.byType(ProductTabBar),
        matching: find.text('Ingredients'),
      );
      await tester.ensureVisible(ingredientsTab);
      await tester.tap(ingredientsTab);
      await tester.pumpAndSettle();
      expect(find.text('Ingredient Analysis'), findsOneWidget);
      expect(find.text('Detailed Breakdown'), findsOneWidget);

      // 3. Tap Nutrition tab in ProductTabBar
      final nutritionTab = find.descendant(
        of: find.byType(ProductTabBar),
        matching: find.text('Nutrition'),
      );
      await tester.ensureVisible(nutritionTab);
      await tester.tap(nutritionTab);
      await tester.pumpAndSettle();
      expect(find.text('Nutrition Information'), findsOneWidget);
      expect(find.text('Per Serving (200g)'), findsOneWidget);

      // 4. Tap Overview tab in ProductTabBar
      final overviewTab = find.descendant(
        of: find.byType(ProductTabBar),
        matching: find.text('Overview'),
      );
      await tester.ensureVisible(overviewTab);
      await tester.tap(overviewTab);
      await tester.pumpAndSettle();
      expect(find.text('Why it scores well'), findsOneWidget);
    });
  });
}
