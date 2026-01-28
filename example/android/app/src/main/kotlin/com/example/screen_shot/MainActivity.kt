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
    private val CHANNEL = "prevent_screen"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableSecure" -> {
                    window.addFlags(LayoutParams.FLAG_SECURE)
                    result.success(true)
                }

                "disableSecure" -> {
                    window.clearFlags(LayoutParams.FLAG_SECURE)
                    result.success(true)
                }

                "getScreensNumber" -> {
                    val screensManager = getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
                    val screenNumbers = screensManager.displays.size
                    result.success(screenNumbers)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}