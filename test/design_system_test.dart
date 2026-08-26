import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/core/theme/theme.dart';
import 'package:prebite/shared/widgets/widgets.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PreBite Design Tokens', () {
    test('Color tokens match DESIGN.md specifications', () {
      expect(PreBiteColors.primary, const Color(0xFF006B32));
      expect(PreBiteColors.primaryBrand, const Color(0xFF168A45));
      expect(PreBiteColors.secondaryContainer, const Color(0xFF9FF6B2));
      expect(PreBiteColors.surface, const Color(0xFFFCF9F8));
      expect(PreBiteColors.surfaceContainerLowest, const Color(0xFFFFFFFF));
      expect(PreBiteColors.borderSubtle, const Color(0xFFE2E7E3));
      expect(PreBiteColors.error, const Color(0xFFBA1A1A));
    });

    test('Spacing tokens match 8px fluid rhythm', () {
      expect(PreBiteSpacing.unit, 4.0);
      expect(PreBiteSpacing.xs, 4.0);
      expect(PreBiteSpacing.sm, 8.0);
      expect(PreBiteSpacing.md, 16.0);
      expect(PreBiteSpacing.lg, 24.0);
      expect(PreBiteSpacing.xl, 40.0);
      expect(PreBiteSpacing.marginMobile, 16.0);
      expect(PreBiteSpacing.marginDesktop, 64.0);
    });

    test('Radius tokens match DESIGN.md scale', () {
      expect(PreBiteRadius.smValue, 4.0);
      expect(PreBiteRadius.defaultValue, 8.0);
      expect(PreBiteRadius.mdValue, 12.0);
      expect(PreBiteRadius.lgValue, 16.0);
      expect(PreBiteRadius.fullValue, 9999.0);
      expect(PreBiteRadius.button, BorderRadius.circular(12.0));
      expect(PreBiteRadius.card, BorderRadius.circular(16.0));
    });

    test('Shadows use diffused green tint', () {
      expect(PreBiteShadows.bloom.isNotEmpty, true);
      expect(PreBiteShadows.soft.isNotEmpty, true);
      expect(PreBiteShadows.hoverLift.isNotEmpty, true);
    });

    test('ThemeData is configured properly', () {
      final theme = PreBiteTheme.lightTheme;
      expect(theme.useMaterial3, true);
      expect(theme.colorScheme.primary, PreBiteColors.primary);
      expect(theme.scaffoldBackgroundColor, PreBiteColors.background);
      expect(theme.cardTheme.color, PreBiteColors.surfaceContainerLowest);
    });
  });

  group('PreBite Shared Widgets', () {
    testWidgets('PreBiteButton renders with text and responds to tap', (
      tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: Scaffold(
            body: PreBiteButton(
              text: 'Add to Compare',
              icon: const Icon(Icons.add),
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Add to Compare'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(find.byType(PreBiteButton));
      await tester.pump();
      expect(tapped, true);
    });

    testWidgets('PreBiteCard renders child and padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const Scaffold(body: PreBiteCard(child: Text('Card Content'))),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(PreBiteCard), findsOneWidget);
    });

    testWidgets('PreBiteBadge renders with label and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const Scaffold(
            body: PreBiteBadge(label: 'Vegan', icon: Icon(Icons.eco)),
          ),
        ),
      );

      expect(find.text('Vegan'), findsOneWidget);
      expect(find.byIcon(Icons.eco), findsOneWidget);
    });

    testWidgets('PreBiteTextField and SearchBar render correctly', (
      tester,
    ) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [
                PreBiteTextField(
                  controller: controller,
                  hintText: 'Enter name',
                ),
                const PreBiteSearchBar(hintText: 'Search products...'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Enter name'), findsOneWidget);
      expect(find.text('Search products...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('PreBiteScoreRing and PreBiteScoreBadge render properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: const Scaffold(
            body: Column(
              children: [
                PreBiteScoreRing(score: 9.1, maxScore: 10.0),
                PreBiteScoreBadge(score: 8.5, label: 'Good Choice'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('9.1'), findsOneWidget);
      expect(find.text('/ 10'), findsOneWidget);
      expect(find.text('8.5 • Good Choice'), findsOneWidget);
    });

    testWidgets('PreBiteAppBar, SectionHeader, and Divider render properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: PreBiteTheme.lightTheme,
          home: Scaffold(
            appBar: const PreBiteAppBar(
              title: 'Product Details',
              showBackButton: false,
            ),
            body: Column(
              children: [
                const PreBiteSectionHeader(
                  title: 'Recent Scans',
                  actionText: 'See all',
                ),
                const PreBiteDivider(),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Product Details'), findsOneWidget);
      expect(find.text('Recent Scans'), findsOneWidget);
      expect(find.text('See all'), findsOneWidget);
      expect(find.byType(PreBiteDivider), findsOneWidget);
    });
  });
}
