## 0.1.0

* **New Feature**: `PreventAppScreen.initialize(bool)` for global, app-wide protection.
* **New Feature**: `FullScreenProtection` widget for screen-specific security.
* **New Feature**: `SpecificWidgetProtection` for granular UI masking (Blur/Placeholder).
* **Enhanced Android**: Implementation of `ScreenCaptureCallback` (Android 14+) and `DisplayListener` for better detection.
* **Enhanced iOS**: Improved screen capture and screenshot detection notifications.
* **New UI**: Added `protectWindow` and `placeholder` features for advanced widget-level control.
* **Documentation**: Major README update with visual guides and detailed API docs.
* **Renaming**: Standardized naming to "Protection" instead of "Proutect".

## 0.0.1

* Initial release (renamed to prevent_app_screen).
* Support for preventing screenshots and screen recordings on Android and iOS.
* Android implementation using WindowManager.LayoutParams.FLAG_SECURE.
* iOS implementation using secure UITextField layer trick.
* iOS App Switcher blurring for increased privacy.
