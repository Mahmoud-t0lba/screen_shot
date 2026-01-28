import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'prevent_app_screen_method_channel.dart';

abstract class PreventAppScreenPlatform extends PlatformInterface {
  PreventAppScreenPlatform() : super(token: _token);

  static final Object _token = Object();

  static PreventAppScreenPlatform _instance = MethodChannelPreventAppScreen();

  static PreventAppScreenPlatform get instance => _instance;

  static set instance(PreventAppScreenPlatform instance) {
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
