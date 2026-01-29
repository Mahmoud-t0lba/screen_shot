//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <prevent_app_screen/prevent_app_screen_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) prevent_app_screen_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PreventAppScreenPlugin");
  prevent_app_screen_plugin_register_with_registrar(prevent_app_screen_registrar);
}
