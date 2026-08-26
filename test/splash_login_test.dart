import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/splash/splash_login_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('SplashLoginScreen UI & Layout', () {
    testWidgets('Renders all Stitch visual elements accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const SplashLoginScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Branding & Intro
      expect(find.text('Know Before You Bite'), findsOneWidget);
      expect(find.text('Scan. Analyze. Decide.'), findsOneWidget);
      expect(
        find.text('Make healthier choices for you and your family.'),
        findsOneWidget,
      );

      // Action Buttons
      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Continue as Guest'), findsOneWidget);

      // Carousel Header & Visible Items
      expect(find.text('Top Picks For You'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
      expect(find.text('Amul Masti Dahi'), findsOneWidget);
      expect(find.text('Mother Dairy'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('Action buttons navigate to Home Dashboard', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.splash);
      await tester.pumpAndSettle();

      final loginFinder = find.text('Log In');
      await tester.ensureVisible(loginFinder);
      await tester.tap(loginFinder);
      await tester.pumpAndSettle();

      expect(find.text('Good Morning, Riya!'), findsOneWidget);
    });

    testWidgets('Top Picks View All navigates to Recommendations', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.splash);
      await tester.pumpAndSettle();

      final viewAllFinder = find.text('View All');
      await tester.ensureVisible(viewAllFinder);
      await tester.tap(viewAllFinder);
      await tester.pumpAndSettle();

      expect(find.text('Best Recommendations For You'), findsWidgets);
    });

    testWidgets('Top Pick card tap navigates to Product Overview', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.splash);
      await tester.pumpAndSettle();

      final cardFinder = find.text('Amul Masti Dahi');
      await tester.ensureVisible(cardFinder);
      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(find.text('Product Details'), findsWidgets);
      expect(find.text('Why it scores well'), findsOneWidget);
    });
  });
}
