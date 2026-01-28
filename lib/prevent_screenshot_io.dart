import 'prevent_screenshot_io_platform_interface.dart';

class PreventScreenshotIo {
  /// Enables screen protection.
  /// On Android, this adds FLAG_SECURE to the window.
  /// On iOS, this uses a secure UITextField to hide the content.
  Future<void> enableSecure() {
    return PreventScreenshotIoPlatform.instance.enableSecure();
  }

  /// Disables screen protection.
  Future<void> disableSecure() {
    return PreventScreenshotIoPlatform.instance.disableSecure();
  }
}
