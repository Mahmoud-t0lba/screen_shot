# 🛡️ Prevent App Screen

[![Pub Version](https://img.shields.io/pub/v/prevent_app_screen?style=flat-square&logo=dart)](https://pub.dev/packages/prevent_app_screen)
[![License](https://img.shields.io/github/license/Mahmoud-t0lba/screen_shot?style=flat-square)](https://github.com/Mahmoud-t0lba/screen_shot/blob/main/LICENSE)
[![Platform Support](https://img.shields.io/badge/platform-android%20%7C%20ios%20%7C%20macos%20%7C%20windows%20%7C%20linux%20%7C%20web-blue?style=flat-square)](https://pub.dev/packages/prevent_app_screen)

A powerful, high-performance Flutter plugin designed to protect your application from **Screenshots** and **Screen Recordings**. Ideal for banking apps, streaming platforms, and privacy-focused tools.

---

## ✨ Key Features

*   🚀 **Global Protection**: Secure your entire app with a single line of code.
*   💻 **Cross-Platform**: Full support for Android, iOS, macOS, Windows, Linux, and Web.
*   📱 **Screen-Level Security**: Dynamic protection that activates/deactivates per route.
*   🌫️ **Granular Masking**: Blur or hide specific UI components (e.g., Credit Card numbers).
*   🔄 **App Switcher Blur**: Automatically hides app content in multitasking views.
*   🎥 **Recording Detection**: Real-time detection and response to screen recordings and mirroring.

---

## 🚀 Getting Started

### Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  prevent_app_screen: ^0.1.2
```

### Basic Initialization

For the best security, initialize the plugin in your `main()` method to protect the entire application from the start.

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable protection globally
  PreventAppScreen.initialize(true); 
  
  runApp(const MyApp());
}
```

---

## 🌟 Protection Levels

### 1️⃣ Full Screen Protection
Wrap specific screens to block screenshots and recording ONLY while that specific page is visible. Useful for login or profile pages.

```dart
@override
Widget build(BuildContext context) {
  return FullScreenProtection(
    prevent: true,
    child: Scaffold(
      appBar: AppBar(title: Text("Sensitive Info")),
      body: MyPrivateContent(),
    ),
  );
}
```

### 2️⃣ Granular Widget Masking
Use `SpecificWidgetProtection` to protect specific UI elements. You can choose between a **Blur effect** or a custom **Placeholder**.

```dart
SpecificWidgetProtection(
  protectWindow: true,   // Blocks the ENTIRE screenshot/recording while visible
  blurAmount: 15.0,      // Intensity of the blur
  placeholder: BlackBox(), // Optional: Show a custom widget instead of blurring
  child: CreditCardWidget(),
)
```

| Parameter       | Type      | Description                                                                 |
|:----------------|:----------|:----------------------------------------------------------------------------|
| `protectWindow` | `bool`    | **Proactive**: Secure the whole window as long as this widget is on screen. |
| `prevent`       | `bool`    | **Reactive**: Auto-blur the widget if a screen recording starts (Mobile).   |
| `forceBlur`     | `bool`    | **Manual**: Always blur the widget regardless of capture status.            |
| `placeholder`   | `Widget?` | Display this widget instead of applying a blur effect.                      |

---

## 🔍 Platform Support & Details

| Feature                  | Android | iOS | macOS | Windows | Linux | Web |
|:-------------------------|:-------:|:---:|:-----:|:-------:|:-----:|:---:|
| **Screenshot Blocking**  |    ✅    |  ✅  |   ✅   |    ✅    |  ⚠️¹  | ⚠️² |
| **Recording Prevention** |    ✅    |  ✅  |   ✅   |    ✅    |  ⚠️¹  | ⚠️² |
| **App Switcher Blur**    |    ✅    |  ✅  |  N/A  |   N/A   |  N/A  | N/A |
| **Capture Detection**    |    ✅    |  ✅  |   ❌   |    ❌    |   ❌   |  ❌  |

### Platform Notes
- ¹ **Linux**: Screenshot prevention is compositor-dependent (X11/Wayland). The plugin provides a success response but actual blocking varies by environment.
- ² **Web**: Browsers do not provide APIs to block screenshots. The plugin applies `user-select: none` to the body as a deterrent.
- **macOS/Windows**: Uses native window affinity APIs to prevent capture by other applications.

---

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
