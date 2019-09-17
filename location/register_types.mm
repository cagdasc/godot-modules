#include <core/class_db.h>
#include <core/engine.h>

#include "register_types.h"
#include "ios/src/godotLocationManager.h"

void register_location_types() {
    Engine::get_singleton()->add_singleton(Engine::Singleton("LocationManager", memnew(GodotLocationManager)));
}

void unregister_location_types() {
}
