package org.godotengine.godot;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Build;
import android.support.v4.content.ContextCompat;
import android.util.Log;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;


public class GodotLocationManager extends Godot.SingletonBase {

    private final int REQUEST_CODE_ACCESS_FINE_LOCATION = 1;
    private Activity mActivity = null;
    private int instance_id = 0;
    private LocationCallback mLocationCallback;
    private FusedLocationProviderClient mFusedLocationClient;
    private boolean initialize = false;
    private boolean locationUpdatesStart = false;

    static public Godot.SingletonBase initialize(Activity activity) {
        return new GodotLocationManager(activity);
    }

    private void init(int instance_id) {
        if (mActivity == null)
            return;

        this.instance_id = instance_id;
        initialize = true;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(mActivity,
                    Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                mActivity.requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_CODE_ACCESS_FINE_LOCATION);
            }
        }

        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(mActivity);
        mLocationCallback = new LocationCallback() {
            @Override
            public void onLocationResult(LocationResult locationResult) {
                if (locationResult == null || locationResult.getLastLocation() == null) {
                    Log.d("GODOT", "Location object is null.");
                    return;
                }

                Location location = locationResult.getLastLocation();

                Dictionary loc = new Dictionary();
                loc.put("longitude", location.getLongitude());
                loc.put("latitude", location.getLatitude());
                loc.put("horizontal_accuracy", location.getAccuracy());
                loc.put("vertical_accuracy", -1.0f);
                loc.put("altitude", location.getAltitude());
                loc.put("speed", location.getSpeed());
                loc.put("time", location.getTime());


                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    loc.put("vertical_accuracy", location.getVerticalAccuracyMeters());
                }

                GodotLib.calldeferred(GodotLocationManager.this.instance_id, "_on_location_results", new Object[]{loc});

            }
        };

    }

    public void startLocationUpdates(int p_interval, int p_maxWaitTime) {
        final long interval = p_interval;
        final long maxWaitTime = p_maxWaitTime;
        mActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!initialize || locationUpdatesStart)
                    return;

                if (ContextCompat.checkSelfPermission(mActivity,
                        Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    Log.d("GODOT", "If you want to location requests, you need to give permission \"ACCESS_FINE_LOCATION\".");
                    return;
                }


                locationUpdatesStart = true;
                LocationRequest request = new LocationRequest();
                request.setInterval(interval);
                request.setMaxWaitTime(maxWaitTime);
                request.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);

                mFusedLocationClient.requestLocationUpdates(request,
                        mLocationCallback, null);
                Log.d("GODOT", "Location update started.");
            }
        });

    }

    public void stopLocationUpdates() {
        mActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (locationUpdatesStart && mLocationCallback != null) {
                    locationUpdatesStart = false;
                    mFusedLocationClient.removeLocationUpdates(mLocationCallback);
                    Log.d("GODOT", "Location update stopped.");
                }
            }
        });

    }

    @Override
    protected void onMainRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onMainRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_CODE_ACCESS_FINE_LOCATION) {
            int i = 0;
            while (i < permissions.length) {
                if (permissions[i].equals("android.permission.ACCESS_FINE_LOCATION")) {
                    GodotLib.calldeferred(GodotLocationManager.this.instance_id,
                            "_on_location_permission_result", new Object[]{permissions[i], grantResults[i]});
                    i = permissions.length;
                }
                i++;
            }
        }
    }

    public GodotLocationManager(Activity p_activity) {
        registerClass("LocationManager", new String[]{
                "init", "startLocationUpdates", "stopLocationUpdates"
        });
        mActivity = p_activity;
    }

}