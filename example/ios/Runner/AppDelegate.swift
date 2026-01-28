import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    weak var screen : UIView? = nil
    var overlayController = UIViewController()
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let preventScreenChannel = FlutterMethodChannel(name: "prevent_screen",
                                                  binaryMessenger: controller.binaryMessenger)
        
        preventScreenChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if call.method == "enableSecure" {
            self.window?.makeSecure()
            result(true)
          } else if call.method == "disableSecure" {
            self.window?.makeInsecure()
            result(true)
          } else {
            result(FlutterMethodNotImplemented)
          }
        })

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenRecordingStatusChanged),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenshotHasTaken),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if UIScreen.main.isCaptured {
                self.displayOverlayControllerWith(
                    message: "Screen recording is not allowed while using the app. Kindly turn off the screen recording to continue using the app."
                )
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationWillResignActive(_ application: UIApplication) {
        self.blurScreen()
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        self.removeBlurScreen()
    }

    @objc func screenRecordingStatusChanged() {
        if UIScreen.main.isCaptured {
            self.displayOverlayControllerWith(
                message: "Screen recording is not allowed while using the app. Kindly turn off the screen recording to continue using the app."
            )
        } else {
            self.overlayController.dismiss(animated: false, completion: nil)
        }
    }

    @objc func screenshotHasTaken() {}

    fileprivate func displayOverlayControllerWith(message : String) {
        if UIApplication.shared.windows.count > 0 {
            let rootWindow = UIApplication.shared.windows[0]
            self.overlayController.view.backgroundColor = .white
            self.overlayController.modalPresentationStyle = .fullScreen

            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height - (rootWindow.safeAreaInsets.top + rootWindow.safeAreaInsets.bottom)
            let frameOfLabel = CGRect(x: 20, y: screenHeight/2 - 100, width: screenWidth - 40, height: 200)

            if let labelMessage = self.overlayController.view.viewWithTag(1010) as? UILabel {
                labelMessage.text = message
            } else {
                let labelMessage = UILabel(frame: frameOfLabel)
                labelMessage.tag = 1010
                labelMessage.numberOfLines = 0
                labelMessage.font = UIFont.systemFont(ofSize: 18, weight: .regular)
                labelMessage.text = message
                labelMessage.textColor = .black
                labelMessage.textAlignment = .center
                self.overlayController.view.addSubview(labelMessage)
            }

            rootWindow.rootViewController?.present(self.overlayController, animated: false, completion: nil)
        }
    }

    func blurScreen(style: UIBlurEffect.Style = .regular) {
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        blurBackground.frame = (screen?.frame)!
        window?.addSubview(screen!)
    }

    func removeBlurScreen() {
        screen?.removeFromSuperview()
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