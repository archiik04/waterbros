import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waterbros/app/app.dart';

void main() {
  testWidgets('WaterBros app welcome screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: WaterBrosApp(),
      ),
    );

    // Verify that the welcome screen starts and has welcome text.
    expect(find.text('Stay Hydrated, Win Together'), findsOneWidget);
  });
}
