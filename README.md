# screen_shot

# IOS Example

<div id="code">
  <pre><code>
    import UIKit
    import Flutter

    @UIApplicationMain
    @objc class AppDelegate: FlutterAppDelegate {
        override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
            GeneratedPluginRegistrant.register(with: self)
            self.window.makeSecure()
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    }

    extension UIWindow {
    func makeSecure() {
        let field = UITextField()
        field.isSecureTextEntry = true
        self.addSubview(field)
        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(self.layer)
      }
    }
  </code></pre>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.8/clipboard.min.js"></script>
<button class="btn" data-clipboard-target="#code">Copy</button>
<script>
  var clipboard = new ClipboardJS('.btn');
</script>

![ios_ex](https://github.com/Mahmoud-t0lba/screen_shot/assets/78425511/28060f1f-2a37-4b20-8e5f-0e864fd11f96)

# Android Example

<div id="code">
  <pre><code>
package com.example.screen_shot
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
  </code></pre>
</div>

![android_ex](https://github.com/Mahmoud-t0lba/screen_shot/assets/78425511/0da6d3a3-2ea0-4969-bfa7-2a334f22b5d4)

