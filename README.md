# prevent_screenshot_io

A Flutter plugin to prevent screenshots and screen recordings on Android and iOS.

## Features

- **Android**: Prevents screenshots and hides app content in the recent apps switcher using `FLAG_SECURE`.
- **iOS**: Prevents screenshots and screen recordings by using a secure `UITextField` layer trick.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  prevent_screenshot_io: ^0.0.1
```

## Usage

```dart
final _preventScreenshotIoPlugin = PreventScreenshotIo();

// Enable protection
await _preventScreenshotIoPlugin.enableSecure();

// Disable protection
await _preventScreenshotIoPlugin.disableSecure();
```

## Example

Check the `example` directory for a full demonstration.
