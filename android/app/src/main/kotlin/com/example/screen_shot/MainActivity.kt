package com.example.screen_shot

import android.content.Context
import android.hardware.display.DisplayManager
import android.util.Log
import android.view.SurfaceView
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "screenNumbers"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        window.addFlags(LayoutParams.FLAG_SECURE)

        if (!setSecureSurfaceView()) {
            Log.e("MainActivity", "Could not secure the MainActivity!")
            // React as appropriate.
        }
//        SurfaceView(applicationContext).setSecure(true) // This line is likely redundant or misplaced.

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
                call, result ->
            if (call.method == "getScreensNumber") {
                val screensManager = getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
                val screenNumbers = screensManager.displays.size

                if (screenNumbers >= 0) { // Check if screenNumbers is non-negative
                    result.success(screenNumbers)
                } else {
                    result.error("UNAVAILABLE", "Screen numbers not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }


    private fun setSecureSurfaceView(): Boolean {
        val content = findViewById<ViewGroup>(android.R.id.content)
        if (!isNonEmptyContainer(content)) {
            Log.w("MainActivity", "Content view is not a non-empty container.")
            return false
        }
        val splashView = content.getChildAt(0)
        if (!isNonEmptyContainer(splashView)) {
            Log.w("MainActivity", "Splash view is not a non-empty container.")
            return false
        }
        val flutterView = (splashView as ViewGroup).getChildAt(0)
        if (!isNonEmptyContainer(flutterView)) {
            Log.w("MainActivity", "Flutter view is not a non-empty container.")
            return false
        }
        // Iterate through children of flutterView to find the SurfaceView
        for (i in 0 until (flutterView as ViewGroup).childCount) {
            val child = flutterView.getChildAt(i)
            if (child is SurfaceView) {
                child.setSecure(true)
                this.window.setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE)
                Log.i("MainActivity", "SurfaceView secured successfully.")
                return true
            }
        }
        Log.e("MainActivity", "SurfaceView not found within FlutterView.")
        return false
    }

    private fun isNonEmptyContainer(view: View?): Boolean {
        return view is ViewGroup && view.childCount > 0
    }
}