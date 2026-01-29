#ifndef FLUTTER_PLUGIN_PREVENT_APP_SCREEN_PLUGIN_H_
#define FLUTTER_PLUGIN_PREVENT_APP_SCREEN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

#include <windows.h>

namespace prevent_app_screen {

class PreventAppScreenPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PreventAppScreenPlugin(HWND window);

  virtual ~PreventAppScreenPlugin();

  // Disallow copy and assign.
  PreventAppScreenPlugin(const PreventAppScreenPlugin&) = delete;
  PreventAppScreenPlugin& operator=(const PreventAppScreenPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

 private:
  HWND window_;
};

}  // namespace prevent_app_screen

#endif  // FLUTTER_PLUGIN_PREVENT_APP_SCREEN_PLUGIN_H_
