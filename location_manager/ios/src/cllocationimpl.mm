#import "cllocationimpl.h"
#include "reference.h"

@implementation CLLocationImpl

- (void)dealloc {
    [super dealloc];
}

- (void)init:(int)instance_id {
    instanceId = instance_id;

    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestWhenInUseAuthorization];
            initialize = NO;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted: {
            initialize = NO;
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        initialize = YES;
            break;
    }
}

- (void) startLocationUpdates {
    if (locationUpdateStart)
		return;

	switch ([CLLocationManager authorizationStatus]) {
		case kCLAuthorizationStatusNotDetermined:
		case kCLAuthorizationStatusDenied:
		case kCLAuthorizationStatusRestricted: {
			return;
		}
		case kCLAuthorizationStatusAuthorizedAlways:
		case kCLAuthorizationStatusAuthorizedWhenInUse:
			CLLocationManager *locationManager = [[CLLocationManager alloc] init];
			locationManager.desiredAccuracy = kCLLocationAccuracyBest;
			locationManager.delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
			[locationManager startUpdatingLocation];
			locationUpdateStart = YES;
			NSLog(@"Location update started.");
			break;
	}
    
}

- (void) stopLocationUpdates {
    if (locationUpdateStart) {
		CLLocationManager *locationManager = [[CLLocationManager alloc] init];
		[locationManager stopUpdatingLocation];
		locationUpdateStart = false;
		NSLog(@"Location update stopped.");
	}
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	CLLocation *lastLoc = [locations lastObject];

    Dictionary ret;

	ret["longitute"] = lastLoc.coordinate.longitute;
	ret["latitude"]  = lastLoc.coordinate.latitude;
	ret["horizontal_accuracy"] = lastLoc.horizontalAccuracy;
	ret["vertical_accuracy"] = lastLoc.verticalAccuracy;
	ret["altitude"] = lastLoc.altitude;
	ret["speed"] = lastLoc.speed;
	ret["time"] = [[NSNumber numberWithDouble:[lastLoc.timestamp timeIntervalSince1970]] unsignedLongLongValue];

    Variant args[VARIANT_ARG_MAX];
    args[0] = ret;
	Object *obj = ObjectDB::get_instance(instanceId);
    obj->call_deferred("_on_location_permission_result", args[0], args[1], args[2], args[3], args[4]);
}

@end
