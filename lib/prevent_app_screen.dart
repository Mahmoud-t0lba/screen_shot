import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'prevent_app_screen_platform_interface.dart';

class PreventAppScreen {
  static bool? _isGloballySecure;
  static int _secureCount = 0;
  static final List<Function(bool)> _capturedListeners = [];

  static Future<void> initialize(bool secure) async {
    if (_isGloballySecure == secure) return;

    _isGloballySecure = secure;
    PreventAppScreenPlatform.instance.setCapturedHandler((isCaptured) {
      for (var listener in _capturedListeners) {
        listener(isCaptured);
      }
    });

    if (secure) {
      await const PreventAppScreen()._enable();
    } else {
      await const PreventAppScreen()._disable();
    }
  }

  const PreventAppScreen();

  void addCapturedListener(Function(bool) listener) => _capturedListeners.add(listener);
  void removeCapturedListener(Function(bool) listener) => _capturedListeners.remove(listener);

  Future<void> enableSecure() async => await _enable();
  Future<void> disableSecure() async => await _disable();

  Future<void> _enable() async {
    _secureCount++;
    if (_secureCount == 1 || (_isGloballySecure ?? false)) {
      await PreventAppScreenPlatform.instance.enableSecure();
    }
  }

  Future<void> _disable() async {
    _secureCount--;
    if (_secureCount < 0) _secureCount = 0;
    if (_secureCount == 0 && !(_isGloballySecure ?? false)) {
      await PreventAppScreenPlatform.instance.disableSecure();
    }
  }
}

/// A widget that protects its content. For screenshots, it can trigger window-wide
/// protection automatically. For recordings, it blurs or hides content.
class SpecificWidgetProtection extends StatefulWidget {
  final Widget child;

  /// The amount of blur to apply. Defaults to 20.
  final double blurAmount;

  /// If true (default), the widget will automatically blur/hide when capture is detected.
  final bool prevent;

  /// If true, the widget will be protected regardless of capture status.
  final bool forceBlur;

  /// If true, this widget will automatically enable app-wide screenshot blocking
  /// as long as this widget is visible (mounted). This is the ONLY way to
  /// guarantee protection in saved screenshot files.
  final bool protectWindow;

  /// An optional widget to show instead of the blurred child when security is active.
  /// If null, a blur effect is used.
  final Widget? placeholder;

  const SpecificWidgetProtection({
    super.key,
    required this.child,
    this.blurAmount = 20.0,
    this.prevent = true,
    this.forceBlur = false,
    this.protectWindow = false,
    this.placeholder,
  });

  @override
  State<SpecificWidgetProtection> createState() => _SpecificWidgetProtectionState();
}

class _SpecificWidgetProtectionState extends State<SpecificWidgetProtection> {
  bool _isCaptured = false;
  final _plugin = const PreventAppScreen();
  bool _windowIsProtected = false;

  @override
  void initState() {
    super.initState();
    _plugin.addCapturedListener(_onCapturedChanged);
    _handleWindowProtection(widget.protectWindow);
  }

  @override
  void didUpdateWidget(SpecificWidgetProtection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.protectWindow != widget.protectWindow) {
      _handleWindowProtection(widget.protectWindow);
    }
  }

  void _handleWindowProtection(bool protect) {
    if (protect && !_windowIsProtected) {
      _plugin.enableSecure();
      _windowIsProtected = true;
    } else if (!protect && _windowIsProtected) {
      _plugin.disableSecure();
      _windowIsProtected = false;
    }
  }

  @override
  void dispose() {
    _plugin.removeCapturedListener(_onCapturedChanged);
    if (_windowIsProtected) _plugin.disableSecure();
    super.dispose();
  }

  void _onCapturedChanged(bool isCaptured) {
    if (mounted) setState(() => _isCaptured = isCaptured);
  }

  @override
  Widget build(BuildContext context) {
    final bool active = widget.forceBlur || (widget.prevent && _isCaptured);

    if (active && widget.placeholder != null) {
      return widget.placeholder!;
    }

    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: active ? widget.blurAmount : 0,
        sigmaY: active ? widget.blurAmount : 0,
      ),
      child: widget.child,
    );
  }
}

/// A widget that prevents screen shots and screen recording while it is active.
class FullScreenProtection extends StatefulWidget {
  final Widget child;
  final bool prevent;

  const FullScreenProtection({super.key, required this.child, this.prevent = true});

  @override
  State<FullScreenProtection> createState() => _FullScreenProtectionState();
}

class _FullScreenProtectionState extends State<FullScreenProtection> {
  final _plugin = const PreventAppScreen();
  bool _isCurrentlyPreventing = false;

  @override
  void initState() {
    super.initState();
    _handlePrevention(widget.prevent);
  }

  @override
  void didUpdateWidget(FullScreenProtection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prevent != widget.prevent) _handlePrevention(widget.prevent);
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
    if (_isCurrentlyPreventing) _plugin.disableSecure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

// Aliases for compatibility
typedef SecureWidget = SpecificWidgetProtection;
typedef PreventWidget = FullScreenProtection;
typedef PreventScreen = FullScreenProtection;
