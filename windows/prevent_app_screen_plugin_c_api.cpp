#include "include/prevent_app_screen/prevent_app_screen_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "prevent_app_screen_plugin.h"

void PreventAppScreenPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  prevent_app_screen::PreventAppScreenPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
