import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/recommendations/data/mock_recommendation_data.dart';
import 'package:prebite/features/recommendations/recommendations_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('MockRecommendationData Validation', () {
    test('Mock recommendation items contain Stitch products', () {
      final items = MockRecommendationData.recommendations;
      expect(items.length, 5);

      final amul = items.firstWhere((p) => p.id == 'amul-masti-dahi');
      expect(amul.name, 'Amul Masti Dahi');
      expect(amul.score, 9.1);
      expect(amul.badgeLabel, 'Excellent Choice');
      expect(amul.highlights.length, 3);

      final hershey = items.firstWhere((p) => p.id == 'hersheys-syrup-400');
      expect(hershey.name, "Hershey's Syrup");
      expect(hershey.score, 6.8);
      expect(hershey.badgeLabel, 'Occasional Choice');
      expect(hershey.isOccasional, isTrue);
    });
  });

  group('RecommendationsScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const RecommendationsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header & App Bar
      expect(find.text('PreBite'), findsWidgets);
      expect(find.text('Recommendations'), findsOneWidget);
      expect(find.text('Best Recommendations For You'), findsOneWidget);
      expect(
        find.text(
          'Products selected based on your preferences, nutrition profile and PreBite score.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.tune), findsOneWidget);

      // Summary Card
      expect(find.text('Made For You'), findsOneWidget);
      expect(
        find.text(
          'These products match your current preferences and health goals.',
        ),
        findsOneWidget,
      );

      // Filter Chips
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.text('Low Sugar'), findsOneWidget);
      expect(find.text('High Protein'), findsOneWidget);
      expect(find.text('Low Sodium'), findsOneWidget);
      expect(find.text('For Family'), findsOneWidget);

      // Sort / Section Title
      expect(find.text('RECOMMENDED FOR YOU'), findsOneWidget);
      expect(find.text('Sort'), findsOneWidget);

      // Product Cards
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('9.1'), findsOneWidget);
      expect(find.text('Excellent Choice'), findsOneWidget);
      expect(find.text('No added sugar'), findsOneWidget);

      expect(find.text('Mother Dairy Classic Curd'), findsOneWidget);
      expect(find.text('8.8'), findsOneWidget);
      expect(find.text('Great Choice'), findsOneWidget);

      expect(find.text('Quaker Oats'), findsOneWidget);
      expect(find.text('8.2'), findsOneWidget);

      expect(find.text('Nestlé a+ Milk'), findsOneWidget);
      expect(find.text('8.0'), findsOneWidget);

      expect(find.text("Hershey's Syrup"), findsOneWidget);
      expect(find.text('6.8'), findsOneWidget);
      expect(find.text('Occasional Choice'), findsOneWidget);
      expect(find.text('Higher added sugar'), findsOneWidget);

      // Bottom Nav Bar
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('Analysis'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Tapping filter chip filters visible products', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const RecommendationsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Initially Hershey is visible
      expect(find.text("Hershey's Syrup"), findsOneWidget);

      // Tap 'Top Rated' filter chip
      final topRatedChip = find.text('Top Rated');
      await tester.tap(topRatedChip);
      await tester.pumpAndSettle();

      // Top rated shows Amul and Mother Dairy, but not Hershey's
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('Mother Dairy Classic Curd'), findsOneWidget);
      expect(find.text("Hershey's Syrup"), findsNothing);
    });

    testWidgets('Favorite button toggles with SnackBar feedback', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const RecommendationsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final firstFavBtn = find.byIcon(Icons.favorite_border).first;
      await tester.tap(firstFavBtn);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added Amul Masti Dahi to Favorites!'), findsOneWidget);
    });

    testWidgets('+ Compare button navigates to /compare', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.recommendations);
      await tester.pumpAndSettle();

      final compareBtn = find.text('+ Compare').first;
      await tester.ensureVisible(compareBtn);
      await tester.tap(compareBtn);
      await tester.pumpAndSettle();

      expect(find.text('Compare Products'), findsWidgets);
      expect(find.text('At a Glance'), findsOneWidget);
    });

    testWidgets('View Details button navigates to Product Overview', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.recommendations);
      await tester.pumpAndSettle();

      final viewDetailsBtn = find.text('View Details').first;
      await tester.ensureVisible(viewDetailsBtn);
      await tester.tap(viewDetailsBtn);
      await tester.pumpAndSettle();

      expect(find.text('Product Details'), findsWidgets);
      expect(find.text('Why it scores well'), findsOneWidget);
    });
  });
}
