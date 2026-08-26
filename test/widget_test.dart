import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prebite/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('PreBiteApp smoke test - mounts SplashLoginScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PreBiteApp());
    await tester.pumpAndSettle();

    expect(find.text('Know Before You Bite'), findsOneWidget);
    expect(find.text('Scan. Analyze. Decide.'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Continue as Guest'), findsOneWidget);
  });
}
