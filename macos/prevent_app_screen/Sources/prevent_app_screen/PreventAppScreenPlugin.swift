import Cocoa
import FlutterMacOS

public class PreventAppScreenPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "prevent_app_screen", binaryMessenger: registrar.messenger)
    let instance = PreventAppScreenPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "enableSecure":
      setSecure(true)
      result(nil)
    case "disableSecure":
      setSecure(false)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func setSecure(_ secure: Bool) {
    DispatchQueue.main.async {
      for window in NSApp.windows {
        if secure {
          window.sharingType = .none
        } else {
          window.sharingType = .readWrite
        }
      }
    }
  }
}
