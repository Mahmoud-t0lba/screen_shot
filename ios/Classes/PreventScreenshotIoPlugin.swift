import Flutter
import UIKit

public class PreventScreenshotIoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "prevent_screenshot_io", binaryMessenger: registrar.messenger())
    let instance = PreventScreenshotIoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "enableSecure":
      if let window = UIApplication.shared.windows.first {
        window.makeSecure()
        result(nil)
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "No window found", details: nil))
      }
    case "disableSecure":
      if let window = UIApplication.shared.windows.first {
        window.makeInsecure()
        result(nil)
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "No window found", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

extension UIWindow {
    func makeSecure() {
        if self.viewWithTag(9999) != nil { return }
        let field = UITextField()
        field.tag = 9999
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last?.addSublayer(self.layer)
    }

    func makeInsecure() {
        if let field = self.viewWithTag(9999) as? UITextField {
            self.layer.superlayer?.addSublayer(self.layer)
            field.removeFromSuperview()
        }
    }
}
