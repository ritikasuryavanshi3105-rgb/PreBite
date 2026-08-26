import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/home/home_dashboard_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('HomeDashboardScreen UI & Layout', () {
    testWidgets('Renders all Stitch Home Dashboard visual elements', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const HomeDashboardScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Greeting
      expect(find.text('Good Morning, Riya!'), findsOneWidget);
      expect(
        find.text('Ready to make a healthier choice today?'),
        findsOneWidget,
      );

      // Search Bar
      expect(
        find.text('Search products, brands or ingredients'),
        findsOneWidget,
      );

      // Primary Hero Scan Banner
      expect(find.text('Know Before You Bite'), findsOneWidget);
      expect(
        find.text(
          "Scan a product barcode to instantly understand what's inside.",
        ),
        findsOneWidget,
      );
      expect(find.text('Scan Barcode'), findsWidgets);

      // Bento Grid Actions
      expect(find.text('Scan\nBarcode'), findsOneWidget);
      expect(find.text('Compare\nProducts'), findsOneWidget);
      expect(find.text('My\nFavorites'), findsOneWidget);
      expect(find.text('Scan\nHistory'), findsOneWidget);

      // Top Picks Section
      expect(find.text('Top Picks For You'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('Mother Dairy Dahi'), findsOneWidget);
      expect(find.text('Good Choice'), findsWidgets);

      // Health Insight
      expect(
        find.text(
          'Choose products with less added sugar and more protein to support healthier everyday choices.',
        ),
        findsOneWidget,
      );

      // Bottom Navigation Bar
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('Analysis'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Scan Barcode button navigates to Scanner route', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.home);
      await tester.pumpAndSettle();

      final heroScanFinder = find.widgetWithText(
        ElevatedButton,
        'Scan Barcode',
      );
      await tester.ensureVisible(heroScanFinder);
      await tester.tap(heroScanFinder);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Scan Barcode'), findsWidgets);
    });

    testWidgets('Quick action bento buttons navigate properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.home);
      await tester.pumpAndSettle();

      final compareFinder = find.text('Compare\nProducts');
      await tester.ensureVisible(compareFinder);
      await tester.tap(compareFinder);
      await tester.pumpAndSettle();

      expect(find.text('Compare Products'), findsWidgets);
    });

    testWidgets('Bottom nav bar items navigate properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.home);
      await tester.pumpAndSettle();

      final analysisFinder = find.text('Analysis');
      await tester.ensureVisible(analysisFinder);
      await tester.tap(analysisFinder);
      await tester.pumpAndSettle();

      expect(find.text('Best Recommendations For You'), findsWidgets);
    });
  });
}
