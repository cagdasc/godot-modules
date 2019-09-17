#ifndef GODOT_LOCATION_MANAGER_H
#define GODOT_LOCATION_MANAGER_H

#include <version_generated.gen.h>

#include "reference.h"

#ifdef __OBJC__
@class CLLocationImpl;
typedef CLLocationImpl *cllocation_impl;
#else
typedef void *cllocation_impl;

#endif


class GodotLocationManager : public Reference {
    
    GDCLASS(GodotLocationManager, Reference);

    bool initialized;
    int godotInstanceId;
    GodotLocationManager *instance;
    cllocation_impl *cllocation_impl_ptr;
    

protected:
    static void _bind_methods();

public:

    void init(int instanceId);
    void startLocationUpdates(int p_priority, int p_max_wait_time);
    void stopLocationUpdates();

    GodotLocationManager();
    ~GodotLocationManager();
};

#endif
