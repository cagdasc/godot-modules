#import "app_delegate.h"
#include "core/dictionary.h"

#import <CoreLocation/CoreLocation.h>

@interface CLLocationImpl: NSObject <CLLocationManagerDelegate> {
    bool initialized = NO;
    bool locationUpdatesStart = NO;
    int instanceId;

}

- (void)init:(int)instance_id;
- (void)startLocationUpdates;
- (void)stopLocationUpdates;

@end
