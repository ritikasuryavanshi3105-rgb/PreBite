import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PreBite Route Definitions', () {
    test('All route constants and names are properly defined', () {
      expect(PreBiteRoutes.splash, '/');
      expect(PreBiteRoutes.login, '/login');
      expect(PreBiteRoutes.home, '/home');
      expect(PreBiteRoutes.scanner, '/scanner');
      expect(PreBiteRoutes.productOverview, '/product/:id');
      expect(PreBiteRoutes.productIngredients, '/product/:id/ingredients');
      expect(PreBiteRoutes.productNutrition, '/product/:id/nutrition');
      expect(PreBiteRoutes.recommendations, '/recommendations');
      expect(PreBiteRoutes.productComparison, '/compare');
      expect(PreBiteRoutes.favoritesHistory, '/history');
      expect(PreBiteRoutes.familyProfiles, '/family-profiles');
      expect(PreBiteRoutes.aiAssistant, '/ai-assistant');
      expect(PreBiteRoutes.profileSettings, '/settings');

      expect(PreBiteRoutes.splashName, 'splash');
      expect(PreBiteRoutes.homeName, 'home');
      expect(PreBiteRoutes.scannerName, 'scanner');
    });

    test('Route path generator helpers create correct URLs', () {
      expect(
        PreBiteRoutes.productOverviewPath('amul-dahi-400'),
        '/product/amul-dahi-400',
      );
      expect(
        PreBiteRoutes.productIngredientsPath('amul-dahi-400'),
        '/product/amul-dahi-400/ingredients',
      );
      expect(
        PreBiteRoutes.productNutritionPath('amul-dahi-400'),
        '/product/amul-dahi-400/nutrition',
      );
    });
  });

  group('PreBite Router Navigation', () {
    testWidgets('Router loads initial splash destination', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Know Before You Bite'), findsOneWidget);
    });

    testWidgets('Router navigates to home dashboard', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.home);
      await tester.pumpAndSettle();

      expect(find.text('Good Morning, Riya!'), findsOneWidget);
    });

    testWidgets('Router navigates to barcode scanner', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.scanner);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Scan Barcode'), findsWidgets);
    });

    testWidgets('Router navigates to product overview with path params', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.productOverviewPath('amul-masti-dahi'));
      await tester.pumpAndSettle();

      expect(find.text('Product Details'), findsWidgets);
      expect(find.text('Why it scores well'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsWidgets);
    });

    testWidgets(
      'Router navigates to ingredients, nutrition, and recommendations',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            theme: PreBiteTheme.lightTheme,
            routerConfig: preBiteRouter,
          ),
        );

        preBiteRouter.go(
          PreBiteRoutes.productIngredientsPath('amul-masti-dahi'),
        );
        await tester.pumpAndSettle();
        expect(find.text('Ingredient Analysis'), findsOneWidget);
        expect(find.text('Detailed Breakdown'), findsOneWidget);

        preBiteRouter.go(PreBiteRoutes.productNutritionPath('amul-masti-dahi'));
        await tester.pumpAndSettle();
        expect(find.text('Nutrition Information'), findsOneWidget);
        expect(find.text('Nutrition Highlights'), findsOneWidget);

        preBiteRouter.go(PreBiteRoutes.recommendations);
        await tester.pumpAndSettle();
        expect(find.text('Best Recommendations For You'), findsWidgets);
      },
    );

    testWidgets(
      'Router navigates to comparison, history, profiles, AI, settings',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            theme: PreBiteTheme.lightTheme,
            routerConfig: preBiteRouter,
          ),
        );

        preBiteRouter.go(PreBiteRoutes.productComparison);
        await tester.pumpAndSettle();
        expect(find.text('Compare Products'), findsWidgets);

        preBiteRouter.go(PreBiteRoutes.favoritesHistory);
        await tester.pumpAndSettle();
        expect(find.text('Favorites & Scan History'), findsWidgets);

        preBiteRouter.go(PreBiteRoutes.familyProfiles);
        await tester.pumpAndSettle();
        expect(find.text('Family Profiles'), findsWidgets);

        preBiteRouter.go(PreBiteRoutes.aiAssistant);
        await tester.pumpAndSettle();
        expect(find.text('PreBite AI Assistant'), findsWidgets);

        preBiteRouter.go(PreBiteRoutes.profileSettings);
        await tester.pumpAndSettle();
        expect(find.text('Profile & Settings'), findsWidgets);
      },
    );
  });
}
