import Flutter
import UIKit

public class PreventAppScreenPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?
    private var isSecure: Bool = false
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "prevent_app_screen", binaryMessenger: registrar.messenger())
        let instance = PreventAppScreenPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "enableSecure":
            if let window = UIApplication.shared.windows.first {
                isSecure = true
                window.makeSecure()
                result(nil)
            } else {
                result(FlutterError(code: "UNAVAILABLE", message: "No window found", details: nil))
            }
        case "disableSecure":
            if let window = UIApplication.shared.windows.first {
                isSecure = false
                window.makeInsecure()
                result(nil)
            } else {
                result(FlutterError(code: "UNAVAILABLE", message: "No window found", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // Auto-blur implementation for the App Switcher
    public func applicationWillResignActive(_ application: UIApplication) {
        if isSecure, let window = UIApplication.shared.windows.first {
            blurScreen(in: window)
        }
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        if let window = UIApplication.shared.windows.first {
            removeBlurScreen(from: window)
        }
    }

    private func blurScreen(in window: UIWindow) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window.bounds
        blurEffectView.tag = 9998
        window.addSubview(blurEffectView)
    }

    private func removeBlurScreen(from window: UIWindow) {
        window.viewWithTag(9998)?.removeFromSuperview()
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
