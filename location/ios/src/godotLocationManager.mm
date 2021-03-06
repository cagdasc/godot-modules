#include "godotLocationManager.h"
#import "app_delegate.h"

#define CLASS_DB ClassDB

GodotLocationManager::GodotLocationManager() {
    ERR_FAIL_COND(instance != NULL);
    instance = this;
    initialized = false;
}

GodotLocationManager::~GodotLocationManager() {
    instance = NULL;
}

void GodotLocationManager::init(int instanceId) {
    if (initialized) {
        NSLog(@"GodotLocationManager Module already initialized");
        return;
    }
    initialized = true;
    godotInstanceId = instanceId;
    cllocation_impl = [CLLocationImpl alloc];
    [cllocation_impl init: instanceId];
}

void GodotLocationManager::startLocationUpdates(int p_priority, int p_max_wait_time) {
    [cllocation_impl startLocationUpdates];
}

void GodotLocationManager::stopLocationUpdates() {
    [cllocation_impl stopLocationUpdates];
}

void GodotLocationManager::_bind_methods() {
    CLASS_DB::bind_method("init",&GodotLocationManager::init);
    CLASS_DB::bind_method("startLocationUpdates",&GodotLocationManager::startLocationUpdates);
    CLASS_DB::bind_method("stopLocationUpdates",&GodotLocationManager::stopLocationUpdates);
}
