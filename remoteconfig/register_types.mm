#include <version_generated.gen.h>

#if VERSION_MAJOR == 3
#include <core/class_db.h>
#include <core/engine.h>
#else
#include "object_type_db.h"
#include "core/globals.h"
#endif

#include "register_types.h"
#include "ios/src/godotRemoteConfig.h"

void register_remoteconfig_types() {
#if VERSION_MAJOR == 3
    Engine::get_singleton()->add_singleton(Engine::Singleton("RemoteConfig", memnew(GodotRemoteConfig)));
#else
    Globals::get_singleton()->add_singleton(Globals::Singleton("RemoteConfig", memnew(GodotRemoteConfig)));
#endif
}

void unregister_remoteconfig_types() {
}
