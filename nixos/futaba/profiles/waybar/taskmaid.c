#include <gio/gio.h>
#include <glib/gprintf.h>
#include <json-glib/json-glib.h>
#include <stdio.h>

#define TASKMAID_ACTIVE_PROP "active"

static void print_active_json(gchar *title, gchar *program, gchar *screen) {
    gchar *tooltip = NULL;
    if (g_strcmp0(title, "")) {
        tooltip = g_strdup_printf("%s (%s) (on %s)", title, program, screen);
    }

    // Build JSON
    g_autoptr(JsonBuilder) builder = json_builder_new();
    json_builder_begin_object(builder);
    json_builder_set_member_name(builder, "text");
    json_builder_add_string_value(builder, title);
    json_builder_set_member_name(builder, "tooltip");
    if (tooltip != NULL) {
        json_builder_add_string_value(builder, tooltip);
    } else {
        json_builder_add_string_value(builder, "");
    }
    json_builder_end_object(builder);
    g_autoptr(JsonNode) root = json_builder_get_root(builder);
    g_autoptr(JsonGenerator) gen = json_generator_new();
    json_generator_set_root(gen, root);
    g_autofree gchar *str = json_generator_to_data(gen, NULL);

    // Print
    g_printf("%s\n", str);
    fflush(stdout);
    // Free
    g_free(tooltip);
}

static void print_active(GVariant *active) {
    gchar *title = NULL;
    gchar *program = NULL;
    gchar *screen = NULL;

    g_variant_get(active, "(sss)", &title, &program, &screen);
    // JSON
    print_active_json(title, program, screen);
}

static void on_prop_change(GDBusProxy *self, GVariant *changed, const gchar* const *invalidated, gpointer user) {
    if (g_variant_n_children(changed) > 0) {
        GVariantIter *iter;
        const gchar *key;
        GVariant *value;
        g_variant_get(changed, "a{sv}", &iter);
        while (g_variant_iter_loop(iter, "{&sv}", &key, &value)) {
            if (!g_strcmp0(key, TASKMAID_ACTIVE_PROP)) {
                print_active(value);
            }
        }
    }
}

int main(int argc, char **argv) {
    GMainLoop *loop = NULL;
    loop = g_main_loop_new(NULL, FALSE);
    GError *err = NULL;
    GDBusProxy *proxy = g_dbus_proxy_new_for_bus_sync(
        G_BUS_TYPE_SESSION,
        G_DBUS_PROXY_FLAGS_NONE,
        NULL,
        "me.lilydjwg.taskmaid",
        "/taskmaid",
        "me.lilydjwg.taskmaid",
        NULL,
        &err
    );
    if (proxy == NULL) {
        g_error("Error connecting to taskmaid: %s\n", err->message);
        return 1;
    }

    // Initial print
    GVariant *active = g_dbus_proxy_get_cached_property(proxy, "active");
    print_active(active);
    g_variant_unref(active);

    g_signal_connect(proxy, "g-properties-changed", G_CALLBACK(on_prop_change), NULL);
    g_main_loop_run(loop);

    if (proxy != NULL) g_object_unref(loop);
    if (loop != NULL) g_main_loop_unref(loop);

    return 0;
}
