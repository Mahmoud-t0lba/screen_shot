import 'package:flutter/widgets.dart';
import 'prevent_app_screen_platform_interface.dart';

class PreventAppScreen {
  static bool? _isGloballySecure;
  static int _secureCount = 0;

  /// Initializes the screen protection.
  /// If [secure] is true, it enables protection globally for the entire app.
  /// If [secure] is false, it removes the global protection requirement.
  static Future<void> initialize(bool secure) async {
    if (_isGloballySecure == secure) return;

    _isGloballySecure = secure;
    if (secure) {
      await const PreventAppScreen()._enable();
    } else {
      await const PreventAppScreen()._disable();
    }
  }

  const PreventAppScreen();

  /// Enables screen protection.
  /// On Android, this adds FLAG_SECURE to the window.
  /// On iOS, this uses a secure UITextField to hide the content.
  Future<void> enableSecure() async {
    await _enable();
  }

  /// Disables screen protection.
  Future<void> disableSecure() async {
    await _disable();
  }

  Future<void> _enable() async {
    _secureCount++;
    // Always call platform enable if we are moving from 0 to 1 or if it's a global force
    if (_secureCount == 1 || (_isGloballySecure ?? false)) {
      await PreventAppScreenPlatform.instance.enableSecure();
    }
  }

  Future<void> _disable() async {
    _secureCount--;
    if (_secureCount < 0) _secureCount = 0;

    // Only call platform disable if no one else is requesting security AND global security is off
    if (_secureCount == 0 && !(_isGloballySecure ?? false)) {
      await PreventAppScreenPlatform.instance.disableSecure();
    }
  }
}

/// A widget that prevents screen shots and screen recording while it is active.
/// This will protect the ENTIRE screen as long as this widget is visible/active.
class PreventWidget extends StatefulWidget {
  final Widget child;

  /// If true, screen protection will be enabled while this widget is in the tree.
  final bool prevent;

  const PreventWidget({super.key, required this.child, this.prevent = true});

  @override
  State<PreventWidget> createState() => _PreventWidgetState();
}

class _PreventWidgetState extends State<PreventWidget> {
  final _plugin = const PreventAppScreen();
  bool _isCurrentlyPreventing = false;

  @override
  void initState() {
    super.initState();
    _handlePrevention(widget.prevent);
  }

  @override
  void didUpdateWidget(PreventWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prevent != widget.prevent) {
      _handlePrevention(widget.prevent);
    }
  }

  void _handlePrevention(bool prevent) {
    if (prevent && !_isCurrentlyPreventing) {
      _plugin.enableSecure();
      _isCurrentlyPreventing = true;
    } else if (!prevent && _isCurrentlyPreventing) {
      _plugin.disableSecure();
      _isCurrentlyPreventing = false;
    }
  }

  @override
  void dispose() {
    if (_isCurrentlyPreventing) {
      _plugin.disableSecure();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Alias for [PreventWidget]
typedef PreventScreen = PreventWidget;
