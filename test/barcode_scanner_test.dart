import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/routing/routing.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/features/scanner/barcode_scanner_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('BarcodeScannerScreen UI & Layout', () {
    testWidgets('Renders all Stitch Barcode Scanner visual elements', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const BarcodeScannerScreen(animateLaser: false),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Top Bar Elements
      expect(find.text('Scan Barcode'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.byIcon(Icons.flash_off_rounded), findsOneWidget);

      // Scanning Instructions
      expect(find.text('Scan the barcode on the product'), findsOneWidget);
      expect(
        find.text(
          'Hold your phone steady and position the barcode inside the frame.',
        ),
        findsOneWidget,
      );

      // Controls Area
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
      expect(find.byIcon(Icons.qr_code_scanner_rounded), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      expect(find.byIcon(Icons.flashlight_off_rounded), findsOneWidget);
      expect(
        find.text('Make sure the barcode is clearly visible'),
        findsOneWidget,
      );
    });

    testWidgets('Toggles flash icon on tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const BarcodeScannerScreen(animateLaser: false),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final flashFinder = find.byTooltip('Toggle Flash');
      expect(flashFinder, findsOneWidget);
      expect(find.byIcon(Icons.flash_off_rounded), findsOneWidget);

      await tester.tap(flashFinder);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byIcon(Icons.flash_on_rounded), findsOneWidget);
    });

    testWidgets('Scan trigger button navigates to Product Overview', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.scanner);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final scanTrigger = find.byIcon(Icons.qr_code_scanner_rounded);
      expect(scanTrigger, findsOneWidget);

      await tester.tap(scanTrigger);
      await tester.pumpAndSettle();

      expect(find.text('Product Details'), findsWidgets);
      expect(find.text('Why it scores well'), findsOneWidget);
    });

    testWidgets('Back button navigates back to Home', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: PreBiteTheme.lightTheme,
          routerConfig: preBiteRouter,
        ),
      );
      preBiteRouter.go(PreBiteRoutes.scanner);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final backButton = find.byIcon(Icons.arrow_back_rounded);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.text('Good Morning, Riya!'), findsOneWidget);
    });
  });
}
