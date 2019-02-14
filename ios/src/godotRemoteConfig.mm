#include "godotRemoteConfig.h"
#import "app_delegate.h"

#if VERSION_MAJOR == 3
#define CLASS_DB ClassDB
#else
#define CLASS_DB ObjectTypeDB
#endif


GodotRemoteConfig::GodotRemoteConfig() {
    ERR_FAIL_COND(instance != NULL);
    instance = this;
    initialized = false;
}

GodotRemoteConfig::~GodotRemoteConfig() {
    instance = NULL;
}

void GodotRemoteConfig::init(int instanceId) {
    if (initialized) {
        NSLog(@"GodotRemoteConfig Module already initialized");
        return;
    }
    cacheExpiration = 0;
    initialized = true;
    godotInstanceId = instanceId;
    remoteConfig = [FIRRemoteConfig remoteConfig];
    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:NO];
    remoteConfig.configSettings = remoteConfigSettings;
    [remoteConfig setDefaultsFromPlistFileName:@"RemoteConfigDefaults"];
    
}

void GodotRemoteConfig::fetch() {
    [remoteConfig fetchWithExpirationDuration:cacheExpiration completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *error) {
        if (status == FIRRemoteConfigFetchStatusSuccess) {
            NSLog(@"Config fetched!");
            [remoteConfig activateFetched];
            Object *obj = ObjectDB::get_instance(godotInstanceId);
            obj->call_deferred("_remote_config_task_successful");
        } else {
            NSLog(@"Config not fetched");
            NSLog(@"Error %@", error.localizedDescription);
            Object *obj = ObjectDB::get_instance(godotInstanceId);
            obj->call_deferred("_remote_config_task_failed");
        }
    }];
}

void GodotRemoteConfig::setCacheExpiration(long expirationDuration) {
    cacheExpiration = expirationDuration;
}

String GodotRemoteConfig::getStringValue(const String &key) {
    NSString *keyStr = [NSString stringWithCString:key.utf8().get_data() encoding: NSUTF8StringEncoding];
    return [remoteConfig[keyStr].stringValue UTF8String];
}

int GodotRemoteConfig::getLongValue(const String &key) {
    NSString *keyStr = [NSString stringWithCString:key.utf8().get_data() encoding: NSUTF8StringEncoding];
    return [remoteConfig[keyStr].numberValue intValue];
}

bool GodotRemoteConfig::getBooleanValue(const String &key) {
    NSString *keyStr = [NSString stringWithCString:key.utf8().get_data() encoding: NSUTF8StringEncoding];
    return remoteConfig[keyStr].boolValue;
}

void GodotRemoteConfig::_bind_methods() {
    CLASS_DB::bind_method("init",&GodotRemoteConfig::init);
    CLASS_DB::bind_method("fetch",&GodotRemoteConfig::fetch);
    CLASS_DB::bind_method("setCacheExpiration",&GodotRemoteConfig::setCacheExpiration);
    CLASS_DB::bind_method("getStringValue",&GodotRemoteConfig::getStringValue);
    CLASS_DB::bind_method("getLongValue",&GodotRemoteConfig::getLongValue);
    CLASS_DB::bind_method("getBooleanValue",&GodotRemoteConfig::getBooleanValue);
}
