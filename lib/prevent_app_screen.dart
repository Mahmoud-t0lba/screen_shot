import 'prevent_app_screen_platform_interface.dart';

class PreventAppScreen {
  /// Enables screen protection.
  /// On Android, this adds FLAG_SECURE to the window.
  /// On iOS, this uses a secure UITextField to hide the content.
  Future<void> enableSecure() {
    return PreventAppScreenPlatform.instance.enableSecure();
  }

  /// Disables screen protection.
  Future<void> disableSecure() {
    return PreventAppScreenPlatform.instance.disableSecure();
  }
}
