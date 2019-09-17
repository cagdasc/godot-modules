#ifndef GODOT_LOCATION_MANAGER_H
#define GODOT_LOCATION_MANAGER_H

#include "core/reference.h"
#include "cllocationimpl.h"

#ifdef __OBJC__
@class CLLocationImpl;
typedef CLLocationImpl *cllocation_impl_ptr;
#else
typedef void *cllocation_impl_ptr;

#endif


class GodotLocationManager : public Reference {
    
    GDCLASS(GodotLocationManager, Reference);

    bool initialized;
    int godotInstanceId;
    GodotLocationManager *instance;
    cllocation_impl_ptr cllocation_impl;
    

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
