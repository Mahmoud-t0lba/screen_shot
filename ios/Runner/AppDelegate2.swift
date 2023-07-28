import UIKit
import Flutter

// for block screen record voice and show alert screen with msg 
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var overlayController = UIViewController()
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        NotificationCenter.default.addObserver(self, selector: #selector(screenRecordingStatusChanged), name: UIScreen.capturedDidChangeNotification, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if UIScreen.main.isCaptured {
                /// when Screen recording is ON app will show that screen alert
                self.displayOverlayControllerWith(message: "Screen recording is not allowed while using the app. Kindly turn off the screen recording to continue using the app.")
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    @objc func screenRecordingStatusChanged() {
        if UIScreen.main.isCaptured {
            self.displayOverlayControllerWith(message: "Screen recording is not allowed while using the app. Kindly turn off the screen recording to continue using the app.")
        } else {
            self.overlayController.dismiss(animated: false, completion: nil)
        }
    }
    fileprivate func displayOverlayControllerWith(message : String) {
        if UIApplication.shared.windows.count > 0 {
            let rootWindow = UIApplication.shared.windows[0]
            self.overlayController.view.backgroundColor = .white
            self.overlayController.modalPresentationStyle = .fullScreen
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height - (rootWindow.safeAreaInsets.top + rootWindow.safeAreaInsets.bottom)
            let frameOfLabel = CGRect.init(x: 20, y: screenHeight/2 - 100, width: screenWidth - 40, height: 200)
            if let labelMessage = self.overlayController.view.viewWithTag(1010) as? UILabel {labelMessage.text = message} else {
                let labelMessage = UILabel.init(frame: frameOfLabel)
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
}
