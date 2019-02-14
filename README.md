# godot-remote-config
Firebase Remote Config module Android and iOS implementation for Godot Engine.

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
