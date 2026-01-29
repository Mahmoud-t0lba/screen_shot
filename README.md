# 🛡️ Prevent App Screen

[![Pub Version](https://img.shields.io/pub/v/prevent_app_screen?style=flat-square&logo=dart)](https://pub.dev/packages/prevent_app_screen)
[![License](https://img.shields.io/github/license/Mahmoud-t0lba/screen_shot?style=flat-square)](https://github.com/Mahmoud-t0lba/screen_shot/blob/main/LICENSE)

A powerful, high-performance Flutter plugin designed to protect your application from **Screenshots** and **Screen Recordings**. Cross-platform support for **Android, iOS, macOS, Windows, Linux, and Web**.

---

## ✨ Key Features
*   🚀 **Global Protection**: Secure your entire app with a single initialization.
*   📱 **Screen-Level Security**: Apply protection to specific routes or pages.
*   🌫️ **Granular Blur (Smart Masking)**: Protect specific UI components while keeping the rest of the app functional.
*   🔄 **App Switcher Blur**: Automatically hides app content in the recent apps/multitasking view (Mobile).
*   🛠️ **Proactive Window Locking**: Automatically blocks screenshots when sensitive widgets are on screen.
*   🎥 **Recording Detection**: Real-time detection and response to screen recordings and mirroring (Mobile).

---

## 🌟 Three Levels of Protection

### 1️⃣ Global Protection (App-Wide)
Best for banking or high-security apps where the entire experience must be private.

<p align="center">
  <img src="https://raw.githubusercontent.com/Mahmoud-t0lba/screen_shot/main/assets/global_protection.png" width="250" alt="Global Protection"/>
</p>

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable protection for every screen in the app
  PreventAppScreen.initialize(true); 
  
  runApp(const MyApp());
}
```

---

### 2️⃣ Full Screen Guard
Wrap specific screens to prevent captures only while that screen is visible.

<p align="center">
  <img src="https://raw.githubusercontent.com/Mahmoud-t0lba/screen_shot/main/assets/screen_protection.png" width="450" alt="Screen Protection"/>
</p>

```dart
@override
Widget build(BuildContext context) {
  return FullScreenProtection(
    prevent: true, // Auto-blocks screenshots for this window
    child: Scaffold(
      appBar: AppBar(title: Text("Secret Settings")),
      body: MyPrivateProfile(),
    ),
  );
}
```

---

### 3️⃣ Specific Widget Protection (Flexible)
Protect specific items (like QR codes or Credit Cards). This mode supports **Blurring** or showing a **Placeholder**.

<p align="center">
  <img src="https://raw.githubusercontent.com/Mahmoud-t0lba/screen_shot/main/assets/specific_widget.png" width="300" alt="Specific Widget Blur"/>
</p>

```dart
SpecificWidgetProtection(
  protectWindow: true,   // Proactive: Blocks screenshots for the whole app ONLY while this is visible
  blurAmount: 15.0,      // Customize the blur intensity
  placeholder: MyLockIcon(), // Optional: Show a custom widget instead of blurring
  child: CreditCardWidget(),
)
```

| Parameter | Description |
| :--- | :--- |
| `protectWindow` | **Proactive Mode**: Blocks the whole app screenshot as long as this widget is on screen. |
| `prevent` | **Detection Mode**: Blurs/Hides the widget automatically if a recording starts. |
| `forceBlur` | **Privacy Mode**: Manually triggers the blur regardless of capture status. |
| `placeholder` | A custom widget to show instead of the blurred child (e.g., a Black Box). |

---

## 🔍 Platform Support & Behavior

| Feature | Android | iOS | macOS | Windows | Linux | Web |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Screenshot Blocking** | ✅ | ✅ | ✅ | ✅ | ⚠️¹ | ⚠️² |
| **Recording Prevention** | ✅ | ✅ | ✅ | ✅ | ⚠️¹ | ⚠️² |
| **App Switcher Blur** | ✅ | ✅ | N/A | N/A | N/A | N/A |
| **Capture Detection** | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |

¹ **Linux**: Support is dependent on the compositor (X11/Wayland). Currently provides a success response but may not reliably block all capture methods.
² **Web**: Browsers do not provide APIs to block screenshots. The plugin applies `user-select: none` as a deterrent.

> **Note**: For Screenshots, the OS typically captures the frame before notifying the app. To reliably block a screenshot file, use `FullScreenProtection` or the `protectWindow` flag in `SpecificWidgetProtection`.

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  prevent_app_screen: ^0.1.1
```

---

## 💬 Aliases (Legacy Support)
The plugin provides these aliases to match your preferred naming style:
- `SecureWidget` -> `SpecificWidgetProtection`
- `PreventWidget` -> `FullScreenProtection`
- `PreventScreen` -> `FullScreenProtection`

---

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
