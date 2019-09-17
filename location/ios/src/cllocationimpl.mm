#import "cllocationimpl.h"
#include "core/reference.h"

@implementation CLLocationImpl

- (void)dealloc {
    [super dealloc];
}

- (void)init:(int)instance_id {
    instanceId = instance_id;

    locationManager = [[CLLocationManager alloc] init];
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestWhenInUseAuthorization];
            initialized = NO;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted: {
            initialized = NO;
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        initialized = YES;
            break;
    }
}

- (void) startLocationUpdates {
    if (!initialized || locationUpdateStart)
		return;

	switch ([CLLocationManager authorizationStatus]) {
		case kCLAuthorizationStatusNotDetermined:
		case kCLAuthorizationStatusDenied:
		case kCLAuthorizationStatusRestricted: {
			return;
		}
		case kCLAuthorizationStatusAuthorizedAlways:
		case kCLAuthorizationStatusAuthorizedWhenInUse:
			locationManager.desiredAccuracy = kCLLocationAccuracyBest;
			locationManager.delegate = self;
			[locationManager startUpdatingLocation];
			locationUpdateStart = YES;
			NSLog(@"Location update started.");
			break;
	}
    
}

- (void) stopLocationUpdates {
    if (locationUpdateStart) {
		[locationManager stopUpdatingLocation];
		locationUpdateStart = NO;
		NSLog(@"Location update stopped.");
	}
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	CLLocation *lastLoc = [locations lastObject];

    Dictionary ret;

	ret["longitude"] = lastLoc.coordinate.longitude;
	ret["latitude"]  = lastLoc.coordinate.latitude;
	ret["horizontal_accuracy"] = lastLoc.horizontalAccuracy;
	ret["vertical_accuracy"] = lastLoc.verticalAccuracy;
	ret["altitude"] = lastLoc.altitude;
	ret["speed"] = lastLoc.speed;
	ret["time"] = [[NSNumber numberWithDouble:[lastLoc.timestamp timeIntervalSince1970]] unsignedLongLongValue];

    Variant args[VARIANT_ARG_MAX];
    args[0] = ret;
	Object *obj = ObjectDB::get_instance(instanceId);
    obj->call_deferred("_on_location_results", ret);
}

@end
