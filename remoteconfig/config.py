def can_build(env, platform):
	return platform=="android" or platform=="iphone"

def configure(env):
	if (env['platform'] == 'android'):
		env.android_add_default_config('applicationId "com.cacaosd.firebaseexamples"')
		env.android_add_gradle_plugin('com.google.gms.google-services')
		env.android_add_gradle_classpath('com.google.gms:google-services:4.3.2')
		env.android_add_dependency('implementation "com.android.support:support-v4:28.0.0"')
		env.android_add_dependency("implementation 'com.google.firebase:firebase-core:17.2.0'")
		env.android_add_dependency("implementation 'com.google.firebase:firebase-config:17.0.0'")
		env.android_add_java_dir("android")
		env.android_add_res_dir("android/res")
		env.disable_module()
            
	if env['platform'] == "iphone":
		env.Append(FRAMEWORKPATH=['modules/remoteconfig/ios/lib'])
		env.Append(CXXFLAGS=['-ferror-limit=0'])
		env.Append(LINKFLAGS=['-ObjC', '-framework', 'FirebaseCore', '-framework', 'FirebaseRemoteConfig'])
