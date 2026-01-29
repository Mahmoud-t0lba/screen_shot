#include "include/prevent_app_screen/prevent_app_screen_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#include "prevent_app_screen_plugin_private.h"

#define PREVENT_APP_SCREEN_PLUGIN(obj)                                         \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), prevent_app_screen_plugin_get_type(),     \
                              PreventAppScreenPlugin))

struct _PreventAppScreenPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(PreventAppScreenPlugin, prevent_app_screen_plugin,
              g_object_get_type())

// Called when a method call is received from Flutter.
static void
prevent_app_screen_plugin_handle_method_call(PreventAppScreenPlugin *self,
                                             FlMethodCall *method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);

  if (strcmp(method, "enableSecure") == 0) {
    // Note: Linux screenshot prevention is highly dependent on the compositor
    // (X11/Wayland). Standard GTK/Flutter doesn't provide a cross-platform way
    // to block captures.
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else if (strcmp(method, "disableSecure") == 0) {
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void prevent_app_screen_plugin_dispose(GObject *object) {
  G_OBJECT_CLASS(prevent_app_screen_plugin_parent_class)->dispose(object);
}

static void
prevent_app_screen_plugin_class_init(PreventAppScreenPluginClass *klass) {
  G_OBJECT_CLASS(klass)->dispose = prevent_app_screen_plugin_dispose;
}

static void prevent_app_screen_plugin_init(PreventAppScreenPlugin *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data) {
  PreventAppScreenPlugin *plugin = PREVENT_APP_SCREEN_PLUGIN(user_data);
  prevent_app_screen_plugin_handle_method_call(plugin, method_call);
}

void prevent_app_screen_plugin_register_with_registrar(
    FlPluginRegistrar *registrar) {
  PreventAppScreenPlugin *plugin = PREVENT_APP_SCREEN_PLUGIN(
      g_object_new(prevent_app_screen_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "prevent_app_screen", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      channel, method_call_cb, g_object_ref(plugin), g_object_unref);

  g_object_unref(plugin);
}
