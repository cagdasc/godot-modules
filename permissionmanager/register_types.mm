#include <core/class_db.h>
#include <core/engine.h>

#include "register_types.h"

void register_permissionmanager_types() {
    Engine::get_singleton()->add_singleton(Engine::Singleton("PermissionManager", memnew(GodotPermissionManager)));
}

void unregister_permissionmanager_types() {
}
