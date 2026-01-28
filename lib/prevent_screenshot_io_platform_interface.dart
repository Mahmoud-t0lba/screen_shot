import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'prevent_screenshot_io_method_channel.dart';

abstract class PreventScreenshotIoPlatform extends PlatformInterface {
  PreventScreenshotIoPlatform() : super(token: _token);

  static final Object _token = Object();

  static PreventScreenshotIoPlatform _instance = MethodChannelPreventScreenshotIo();

  static PreventScreenshotIoPlatform get instance => _instance;

  static set instance(PreventScreenshotIoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> enableSecure() {
    throw UnimplementedError('enableSecure() has not been implemented.');
  }

  Future<void> disableSecure() {
    throw UnimplementedError('disableSecure() has not been implemented.');
  }
}
