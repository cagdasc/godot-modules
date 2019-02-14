package org.godotengine.godot;

import android.app.Activity;
import android.support.annotation.NonNull;
import android.provider.Settings;
import android.util.Log;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;
import com.godot.game.BuildConfig;
import com.godot.game.R;

public class GodotRemoteConfig extends Godot.SingletonBase {

	private Activity activity = null;
	private int instance_id = 0;
	private long cacheExpiration = 0;
	private FirebaseRemoteConfig mFirebaseRemoteConfig;

	public void init(int instance_id) {
		this.instance_id = instance_id;
		mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance();
		FirebaseRemoteConfigSettings configSettings = new FirebaseRemoteConfigSettings.Builder()
				.setDeveloperModeEnabled(BuildConfig.DEBUG).build();
		mFirebaseRemoteConfig.setConfigSettings(configSettings);
		mFirebaseRemoteConfig.setDefaults(R.xml.remote_config);
	}

	public void fetch() {
		activity.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				mFirebaseRemoteConfig.fetch(cacheExpiration).addOnCompleteListener(activity, new OnCompleteListener<Void>() {
					@Override
					public void onComplete(@NonNull Task<Void> task) {
						if (task.isSuccessful()) {
							Log.d("GodotRemoteConfig", "Fetch Successful");
							mFirebaseRemoteConfig.activateFetched();
							GodotLib.calldeferred(instance_id, "_remote_config_task_successful", new Object[] {});
						} else {
							Log.d("GodotRemoteConfig", "Fetch Failed.");
							GodotLib.calldeferred(instance_id, "_remote_config_task_failed", new Object[] {});
						}
					}
				});
			}
		});
	}

	public void setCacheExpiration(long cacheExpiration) {
		this.cacheExpiration = cacheExpiration;
	}

	public String getStringValue(String key) {
		return mFirebaseRemoteConfig.getString(key);
	}

	public int getLongValue(String key) {
		return (int)mFirebaseRemoteConfig.getLong(key);
	}

	public boolean getBooleanValue(String key) {
		return mFirebaseRemoteConfig.getBoolean(key);
	}

	static public Godot.SingletonBase initialize(Activity activity) {
		return new GodotRemoteConfig(activity);
	}

	public GodotRemoteConfig(Activity p_activity) {
		registerClass("RemoteConfig", new String[] {
			"init", "fetch", "setCacheExpiration", "getStringValue", "getLongValue", "getBooleanValue"
		});
		activity = p_activity;
	}
}
