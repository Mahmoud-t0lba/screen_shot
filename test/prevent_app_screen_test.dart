import 'package:flutter_test/flutter_test.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';
import 'package:prevent_app_screen/prevent_app_screen_platform_interface.dart';
import 'package:prevent_app_screen/prevent_app_screen_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/widgets.dart';

class MockPreventAppScreenPlatform extends PreventAppScreenPlatform with MockPlatformInterfaceMixin {
  int enableSecureCount = 0;
  int disableSecureCount = 0;
  Function(bool)? capturedHandler;

  @override
  Future<void> enableSecure() async {
    enableSecureCount++;
  }

  @override
  Future<void> disableSecure() async {
    disableSecureCount++;
  }

  @override
  void setCapturedHandler(Function(bool isCaptured) onCaptured) {
    capturedHandler = onCaptured;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPreventAppScreenPlatform mockPlatform;

  setUp(() {
    mockPlatform = MockPreventAppScreenPlatform();
    PreventAppScreenPlatform.instance = mockPlatform;
  });

  test('$MethodChannelPreventAppScreen is the default instance', () {
    expect(PreventAppScreenPlatform.instance, isA<MethodChannelPreventAppScreen>());
  });

  group('PreventAppScreen API', () {
    test('initialize(true) enables secure and sets handler', () async {
      await PreventAppScreen.initialize(true);
      expect(mockPlatform.enableSecureCount, 1);
      expect(mockPlatform.capturedHandler, isNotNull);
    });

    test('initialize(false) disables secure and sets handler', () async {
      await PreventAppScreen.initialize(false);
      expect(mockPlatform.disableSecureCount, 1);
      expect(mockPlatform.capturedHandler, isNotNull);
    });

    test('enableSecure increments count and calls platform', () async {
      const plugin = PreventAppScreen();
      await plugin.enableSecure();
      expect(mockPlatform.enableSecureCount, 1);

      await plugin.enableSecure();
      expect(mockPlatform.enableSecureCount, 2);
    });

    test('disableSecure decrements count and calls platform when zero', () async {
      const plugin = PreventAppScreen();
      // Reset from previous tests if necessary (though _secureCount is static)
      // Since it's static, we should be careful.
      // For testing purposes, we usually assume a fresh state or handle resets.
      // But let's just test the flow.

      await plugin.enableSecure(); // 1
      await plugin.disableSecure(); // 0
      expect(mockPlatform.disableSecureCount, 1);
    });

    test('captured listeners are notified', () async {
      await PreventAppScreen.initialize(true);
      bool notifiedValue = false;
      void listener(bool val) => notifiedValue = val;

      const plugin = PreventAppScreen();
      plugin.addCapturedListener(listener);

      mockPlatform.capturedHandler!(true);
      expect(notifiedValue, true);

      plugin.removeCapturedListener(listener);
      mockPlatform.capturedHandler!(false);
      expect(notifiedValue, true); // Should not have changed
    });
  });

  group('Widgets', () {
    testWidgets('FullScreenProtection calls enableSecure on init', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FullScreenProtection(
            prevent: true,
            child: Text('Protected'),
          ),
        ),
      );

      expect(mockPlatform.enableSecureCount, 1);

      await tester.pumpWidget(Container()); // Dispose
      expect(mockPlatform.disableSecureCount, 1);
    });

    testWidgets('SpecificWidgetProtection with protectWindow calls enableSecure', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SpecificWidgetProtection(
            protectWindow: true,
            child: Text('Widget'),
          ),
        ),
      );

      expect(mockPlatform.enableSecureCount, 1);

      await tester.pumpWidget(Container()); // Dispose
      expect(mockPlatform.disableSecureCount, 1);
    });
  });
}
