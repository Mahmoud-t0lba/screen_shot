#include "prevent_app_screen_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

namespace prevent_app_screen {

// static
void PreventAppScreenPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "prevent_app_screen",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<PreventAppScreenPlugin>(
      registrar->GetView()->GetNativeWindow());

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

PreventAppScreenPlugin::PreventAppScreenPlugin(HWND window) : window_(window) {}

PreventAppScreenPlugin::~PreventAppScreenPlugin() {}

void PreventAppScreenPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("enableSecure") == 0) {
    if (window_) {
      SetWindowDisplayAffinity(window_, WDA_MONITOR);
    }
    result->Success();
  } else if (method_call.method_name().compare("disableSecure") == 0) {
    if (window_) {
      SetWindowDisplayAffinity(window_, WDA_NONE);
    }
    result->Success();
  } else {
    result->NotImplemented();
  }
}

} // namespace prevent_app_screen
