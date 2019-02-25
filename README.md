# godot-remote-config
Firebase Remote Config module Android and iOS implementation for Godot Engine.

## Compile
Copy `remoteconfig` directory to `godot/modules`.

__Android:__

    user@host:~/godot$ scons -j8 platform=android target=release_debug
    user@host:~/godot$ scons -j8 platform=android target=release_debug android_arch=x86
    user@host:~/godot$ cd platform/android/java
    user@host:~/godot/platform/android/java$ ./gradlew build

__iOS:__

    user@host:~/godot$ scons -j8 platform=iphone target=debug

## Configuration
Add default values to `android/res/xml/remote_config.xml` or `ios/src/RemoteConfigDefaults.plist`

Add modules to `project.godot` for Android

    [android]
    modules="org/godotengine/godot/GodotRemoteConfig"

## Methods
```python
# initialization function
init(instance_id)

# set cache expiration duration
setCacheExpiration(cacheExpiration)

# fetch very first remote configs
fetch()

# get your String values
getStringValue()

# get your long values
getLongValue()

# get your boolean values
getBooleanValue()
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