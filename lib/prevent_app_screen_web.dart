// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'prevent_app_screen_platform_interface.dart';

/// A web implementation of the PreventAppScreenPlatform of the PreventAppScreen plugin.
class PreventAppScreenWeb extends PreventAppScreenPlatform {
  /// Constructs a PreventAppScreenWeb
  PreventAppScreenWeb();

  static void registerWith(Registrar registrar) {
    PreventAppScreenPlatform.instance = PreventAppScreenWeb();
  }

  @override
  Future<void> enableSecure() async {
    // Web browsers do not provide an API to block screenshots.
    // However, we can disable text selection as a deterrent.
    web.document.body?.style.setProperty('user-select', 'none');
    web.document.body?.style.setProperty('-webkit-user-select', 'none');
  }

  @override
  Future<void> disableSecure() async {
    web.document.body?.style.removeProperty('user-select');
    web.document.body?.style.removeProperty('-webkit-user-select');
  }

  @override
  void setCapturedHandler(Function(bool isCaptured) onCaptured) {
    // Screen capture detection is not supported on Web.
  }
}
