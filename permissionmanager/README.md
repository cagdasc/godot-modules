# PermissionManager

Android runtime permissions implementation. You can give access the permission on runtime.

__IMPORTANT:__ This module is only compatable with Godot 3.1 and 3.1.1

## Usage

You need to compile source with this module and add line at below to *project.godot* for android. After you can follow __Reference__ section.

    [android]
    modules="org/godotengine/godot/GodotPermissionManager"

## References

```python

# get singleton and do not forget null check because of it only available for android.
var permission_manager = Engine.get_singleton("PermissionManager")

# init permission manager singleton
permission_manager.init(get_instance_id())

# you can give access to permission which given index
# p_permission_key -> permission index. for more detail check permissions.txt
permission_manager.requestPermission(p_permission_key)

# you can give access to permissions at same time which given indexes
# p_permission_array -> permissions indexes array(PoolIntArray). for more detail check permissions.txt
permission_manager.requestPermissions(p_permission_array)

# you can check permission status which given index
# p_permission_key -> permission index. for more detail check permissions.txt
permission_manager.checkPermissionStatus(p_permission_key)

# you can get permission name which given index
# p_permission_key -> permission index. for more detail check permissions.txt
permission_manager.getPermissionName(p_permission_key)

# permission request callback. it will give you status which requesting permission
# permission -> which permission does giving access.
# granted -> granted status true/false.
func _on_permission_result(permission, granted)


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
