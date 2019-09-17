#import "app_delegate.h"
#include "core/dictionary.h"

#import <CoreLocation/CoreLocation.h>

@interface CLLocationImpl: NSObject <CLLocationManagerDelegate> {
    bool initialized;
    bool locationUpdateStart;
    int instanceId;
    CLLocationManager *locationManager;

}

- (void)init:(int)instance_id;
- (void)startLocationUpdates;
- (void)stopLocationUpdates;

@end
