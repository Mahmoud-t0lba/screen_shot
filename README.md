# prevent_app_screen

A Flutter plugin to prevent screenshots and screen recordings on Android and iOS.

## Features

- **Android**: Prevents screenshots and hides app content in the recent apps switcher using `FLAG_SECURE`.
- **iOS**: Prevents screenshots and screen recordings by using a secure `UITextField` layer trick.
- **iOS App Switcher**: Automatically blurs the app content when it goes to the background.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  prevent_app_screen: ^0.0.1
```

## Usage

```dart
final _preventAppScreenPlugin = PreventAppScreen();

// Enable protection
await _preventAppScreenPlugin.enableSecure();

// Disable protection
await _preventAppScreenPlugin.disableSecure();
```

## Example

Check the `example` directory for a full demonstration.
