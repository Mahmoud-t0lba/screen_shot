import 'package:flutter_test/flutter_test.dart';
import 'package:prevent_app_screen_example/main.dart';

void main() {
  testWidgets('Verify Menu shows up', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the menu items are present.
    expect(find.text('Full Screen Protection'), findsOneWidget);
    expect(find.text('Specific Widget Protection'), findsOneWidget);
  });
}
