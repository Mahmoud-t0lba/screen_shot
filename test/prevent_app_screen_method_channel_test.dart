import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prevent_app_screen/prevent_app_screen_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPreventAppScreen platform = MethodChannelPreventAppScreen();
  const MethodChannel channel = MethodChannel('prevent_app_screen');

  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      },
    );
    log.clear();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('enableSecure invokes method on channel', () async {
    await platform.enableSecure();
    expect(log, <Matcher>[
      isMethodCall('enableSecure', arguments: null),
    ]);
  });

  test('disableSecure invokes method on channel', () async {
    await platform.disableSecure();
    expect(log, <Matcher>[
      isMethodCall('disableSecure', arguments: null),
    ]);
  });

  test('setCapturedHandler sets handler on channel', () async {
    bool? captured;
    platform.setCapturedHandler((val) => captured = val);

    // Simulate a callback from the platform
    final ByteData? message = const StandardMethodCodec().encodeMethodCall(
      const MethodCall('onCapturedChanged', true),
    );

    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
      'prevent_app_screen',
      message,
      (ByteData? data) {},
    );

    expect(captured, true);
  });
}
