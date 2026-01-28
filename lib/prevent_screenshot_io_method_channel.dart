import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'prevent_screenshot_io_platform_interface.dart';

class MethodChannelPreventScreenshotIo extends PreventScreenshotIoPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('prevent_screenshot_io');

  @override
  Future<void> enableSecure() async {
    await methodChannel.invokeMethod<void>('enableSecure');
  }

  @override
  Future<void> disableSecure() async {
    await methodChannel.invokeMethod<void>('disableSecure');
  }
}
