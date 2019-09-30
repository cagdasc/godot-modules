# LocationManager

Android and iOS location implementation. You can create location based games with this module.

__IMPORTANT:__ This module is only compatable with Godot 3.1 and 3.1.1

## Usage

You need to compile source with this module and add line at below to *project.godot* for android. After you can follow __Reference__ section.

    [android]
    modules="org/godotengine/godot/GodotLocationManager"

## References

```python

# get singleton and do not forget null check because of it only available for android and ios.
var location_manager = Engine.get_singleton("LocationManager")

# init location manager singleton
location_manager.init(get_instance_id())

# start location updates. default priority is LocationRequest.PRIORITY_HIGH_ACCURACY
# p_interval -> To specify the interval at which location is computed for your app.
# p_maxWaitTime  -> Maximum wait time in milliseconds for location updates.
# https://developer.android.com/guide/topics/location/battery#frequency
location_manager.startLocationUpdates(p_interval, p_maxWaitTime)

# stop location updates.
location_manager.stopLocationUpdates()

# if your app doesn't give location permission, you can take it with this module(init() func) and get results in this callback.
# permission -> which permission does giving access.
# granted -> granted status true/false.
func _on_location_permission_result(permission, granted)

# location result is emiting with this signal. location param type is dictionary.
func _on_location_results(location):
    print(str(loc.longitude))
    print(str(loc.latitude))
    print(str(loc.horizontal_accuracy))
    print(str(loc.vertical_accuracy))
    print(str(loc.altitude))
    print(str(loc.speed))
    print(str(loc.time))


```

    Copyright 2019 Cagdas Caglak

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
