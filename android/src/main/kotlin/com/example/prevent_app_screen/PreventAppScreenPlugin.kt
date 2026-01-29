package com.example.prevent_app_screen

import android.app.Activity
import android.content.Context
import android.hardware.display.DisplayManager
import android.os.Build
import android.view.Display
import android.view.WindowManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PreventAppScreenPlugin */
class PreventAppScreenPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var displayManager: DisplayManager? = null

  private val displayListener = object : DisplayManager.DisplayListener {
    override fun onDisplayAdded(displayId: Int) {
      checkCaptureStatus()
    }
    override fun onDisplayRemoved(displayId: Int) {
      checkCaptureStatus()
    }
    override fun onDisplayChanged(displayId: Int) {
      checkCaptureStatus()
    }
  }

  // For Android 14+
  private var screenCaptureCallback: Any? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "prevent_app_screen")
    channel.setMethodCallHandler(this)
    displayManager = flutterPluginBinding.applicationContext.getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
    displayManager?.registerDisplayListener(displayListener, null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "enableSecure" -> {
        activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        result.success(null)
      }
      "disableSecure" -> {
        activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        result.success(null)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun checkCaptureStatus() {
    val isCaptured = isScreenBeingCaptured()
    activity?.runOnUiThread {
      channel.invokeMethod("onCapturedChanged", isCaptured)
    }
  }

  private fun isScreenBeingCaptured(): Boolean {
    val displays = displayManager?.displays ?: return false
    for (display in displays) {
      if (display.displayId != Display.DEFAULT_DISPLAY) {
        val flags = display.flags
        if (flags and Display.FLAG_SECURE == 0) {
          // If a non-default display is not secure, it might be a recording/cast
          return true
        }
      }
    }
    return false
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    displayManager?.unregisterDisplayListener(displayListener)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    registerScreenCaptureCallback()
    checkCaptureStatus()
  }

  private fun registerScreenCaptureCallback() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
      val callback = Activity.ScreenCaptureCallback {
        checkCaptureStatus()
      }
      activity?.registerScreenCaptureCallback(activity!!.mainExecutor, callback)
      screenCaptureCallback = callback
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    unregisterScreenCaptureCallback()
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    registerScreenCaptureCallback()
  }

  override fun onDetachedFromActivity() {
    unregisterScreenCaptureCallback()
    activity = null
  }

  private fun unregisterScreenCaptureCallback() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
      screenCaptureCallback?.let {
        activity?.unregisterScreenCaptureCallback(it as Activity.ScreenCaptureCallback)
      }
      screenCaptureCallback = null
    }
  }
}
