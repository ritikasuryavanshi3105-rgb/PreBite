import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/comparison/data/mock_comparison_data.dart';
import 'package:prebite/features/comparison/product_comparison_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('MockComparisonData Validation', () {
    test('Default comparison data contains Amul vs Mother Dairy', () {
      final data = MockComparisonData.defaultComparison;
      expect(data.product1.name, 'Masti Dahi');
      expect(data.product1.brand, 'AMUL');
      expect(data.product1.score, 9.1);
      expect(data.product1.isWinner, isTrue);

      expect(data.product2.name, 'Classic Curd');
      expect(data.product2.brand, 'MOTHER DAIRY');
      expect(data.product2.score, 8.8);

      expect(data.atAGlanceMetrics.length, 4);
      expect(data.detailedNutrients.length, 9);
      expect(data.winnerTitle, 'Amul Masti Dahi');
    });
  });

  group('ProductComparisonScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const ProductComparisonScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Top Bar & Intro
      expect(find.text('Compare Products'), findsWidgets);
      expect(
        find.text('See which product is the better choice for you.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Side-by-side Product Cards
      expect(find.text('AMUL'), findsWidgets);
      expect(find.text('MOTHER DAIRY'), findsWidgets);
      expect(find.text('Masti Dahi'), findsOneWidget);
      expect(find.text('Classic Curd'), findsOneWidget);
      expect(find.text('9.1'), findsWidgets);
      expect(find.text('8.8'), findsWidgets);
      expect(find.text('Excellent Choice'), findsOneWidget);
      expect(find.text('Great Choice'), findsOneWidget);

      // Best Choice Winner Banner
      expect(find.text('BEST CHOICE FOR YOU'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(
        find.textContaining('With a higher PreBite score of 9.1'),
        findsOneWidget,
      );

      // At a Glance Table
      expect(find.text('At a Glance'), findsOneWidget);
      expect(find.text('METRIC'), findsWidgets);
      expect(find.text('Score'), findsOneWidget);
      expect(find.text('Protein'), findsWidgets);
      expect(find.text('Added Sugar'), findsOneWidget);
      expect(find.text('Total Fat'), findsWidgets);

      // Detailed Nutrition Table
      expect(find.text('Detailed Nutrition'), findsOneWidget);
      expect(find.text('Per 100g'), findsOneWidget);
      expect(find.text('Calories'), findsOneWidget);
      expect(find.text('61 kcal'), findsOneWidget);
      expect(find.text('65 kcal'), findsOneWidget);
      expect(find.text('Carbohydrates'), findsOneWidget);
      expect(find.text('Total Sugars'), findsOneWidget);
      expect(find.text('Added Sugars'), findsOneWidget);
      expect(find.text('Saturated Fat'), findsOneWidget);
      expect(find.text('Sodium'), findsOneWidget);
      expect(find.text('Calcium'), findsOneWidget);

      // Our Recommendation Card
      expect(find.text('Our Recommendation'), findsOneWidget);
      expect(
        find.textContaining(
          'Both products offer a simple, clean ingredient profile',
        ),
        findsOneWidget,
      );
      expect(find.text('View Amul Details'), findsOneWidget);
      expect(find.text('Add to Favorites'), findsOneWidget);

      // Bottom Navigation Bar
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('Analysis'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Add to Favorites button toggles state with feedback', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const ProductComparisonScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final favButton = find.text('Add to Favorites');
      await tester.ensureVisible(favButton);
      await tester.tap(favButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added Masti Dahi to Favorites!'), findsOneWidget);
      expect(find.text('Favorited'), findsOneWidget);
    });

    testWidgets('View Amul Details button navigates to Product Overview', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.productComparison);
      await tester.pumpAndSettle();

      final viewDetailsButton = find.text('View Amul Details');
      await tester.ensureVisible(viewDetailsButton);
      await tester.tap(viewDetailsButton);
      await tester.pumpAndSettle();

      expect(find.text('Product Details'), findsWidgets);
      expect(find.text('Why it scores well'), findsOneWidget);
    });
  });
}
