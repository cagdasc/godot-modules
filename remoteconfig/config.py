def can_build(plat):
	return plat=="android" or plat=="iphone"

def configure(env):
	if (env['platform'] == 'android'):
		env.android_add_dependency("implementation 'com.google.firebase:firebase-core:16.0.6'")
		env.android_add_dependency("implementation 'com.google.firebase:firebase-config:16.1.3'")
		env.android_add_java_dir("android")
		env.android_add_res_dir("android/res")
		env.disable_module()
            
	if env['platform'] == "iphone":
		env.Append(FRAMEWORKPATH=['modules/remoteconfig/ios/lib'])
		env.Append(CXXFLAGS=['-ferror-limit=0'])
		env.Append(LINKFLAGS=['-ObjC', '-framework', 'FirebaseCore', '-framework', 'FirebaseRemoteConfig'])
