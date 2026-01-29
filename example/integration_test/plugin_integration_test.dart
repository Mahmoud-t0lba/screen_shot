import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('enableSecure test', (WidgetTester tester) async {
    const PreventAppScreen plugin = PreventAppScreen();
    // Verify that the call doesn't throw.
    await plugin.enableSecure();
    await plugin.disableSecure();
  });
}
