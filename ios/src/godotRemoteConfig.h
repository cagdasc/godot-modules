#ifndef GODOT_REMOTECONFIG_H
#define GODOT_REMOTECONFIG_H

#include <version_generated.gen.h>

#include "reference.h"

#import <FirebaseRemoteConfig/FirebaseRemoteConfig.h>

class GodotRemoteConfig : public Reference {
    
#if VERSION_MAJOR == 3
    GDCLASS(GodotRemoteConfig, Reference);
#else
    OBJ_TYPE(GodotRemoteConfig, Reference);
#endif

    bool initialized;
    int godotInstanceId;
    GodotRemoteConfig *instance;
    FIRRemoteConfig *remoteConfig;
    long cacheExpiration;

protected:
    static void _bind_methods();

public:

    void init(int instanceId);
    void fetch();
    void setCacheExpiration(long cacheExpiration);
    String getStringValue(const String &key);
    int getLongValue(const String &key);
    bool getBooleanValue(const String &key);

    GodotRemoteConfig();
    ~GodotRemoteConfig();
};

#endif
