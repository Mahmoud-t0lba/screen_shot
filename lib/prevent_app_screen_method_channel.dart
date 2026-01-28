import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'prevent_app_screen_platform_interface.dart';

class MethodChannelPreventAppScreen extends PreventAppScreenPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('prevent_app_screen');

  @override
  Future<void> enableSecure() async {
    await methodChannel.invokeMethod<void>('enableSecure');
  }

  @override
  Future<void> disableSecure() async {
    await methodChannel.invokeMethod<void>('disableSecure');
  }
}
