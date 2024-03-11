package com.iyaffle.launchreview;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import 	android.content.pm.ActivityInfo;
import android.widget.Toast;

import androidx.annotation.NonNull;

import java.util.List;
/**
 * LaunchReviewPlugin
 */
public class LaunchReviewPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {
    Activity activity;

    private static LaunchReviewPlugin register(LaunchReviewPlugin plugin, BinaryMessenger messenger, Activity activity) {
        final MethodChannel channel = new MethodChannel(messenger, "launch_review");
        plugin.activity = activity;
        channel.setMethodCallHandler(plugin);
        return plugin;
    }

    /**
     * Plugin registration.
     */
    @SuppressWarnings("deprecation")
    public static void registerWith(PluginRegistry.Registrar registrar) {
        register(new LaunchReviewPlugin(), registrar.messenger(), registrar.activity());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("launch")) {
            String appId = call.argument("android_id");
            String toastMessage = call.argument("toast_message");
            boolean showToast = call.argument("show_toast");

            if (appId == null) {
                appId = activity.getPackageName();
            }

            if (toastMessage == null){
                toastMessage = "Please Rate Application";
            }
            Intent rateIntent = new Intent(Intent.ACTION_VIEW,
                    Uri.parse("market://details?id=" + appId));
            boolean marketFound = false;

            // find all applications able to handle our rateIntent
            final List<ResolveInfo> otherApps =  activity.getPackageManager()
                    .queryIntentActivities(rateIntent, 0);
            for (ResolveInfo otherApp: otherApps) {
                // look for Google Play application
                if (otherApp.activityInfo.applicationInfo.packageName
                        .equals("com.android.vending")) {

                    ActivityInfo otherAppActivity = otherApp.activityInfo;
                    ComponentName componentName = new ComponentName(
                            otherAppActivity.applicationInfo.packageName,
                            otherAppActivity.name
                    );
                    // make sure it does NOT open in the stack of your activity
                    rateIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    // task reparenting if needed
                    rateIntent.addFlags(Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
                    // if the Google Play was already open in a search result
                    //  this make sure it still go to the app page you requested
                    rateIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    // this make sure only the Google Play app is allowed to
                    // intercept the intent
                    rateIntent.setComponent(componentName);
                   if (showToast){
                        Toast.makeText(activity, toastMessage, Toast.LENGTH_SHORT).show();
                   } 

                    activity.startActivity(rateIntent);
                    marketFound = true;
                    break;

                }
            }

            // if GP not present on device, open web browser
            if (!marketFound) {
                try {
                    activity.startActivity(new Intent(Intent.ACTION_VIEW,
                            Uri.parse("market://details?id=" + appId)));
                } catch (ActivityNotFoundException e) {
                    activity.startActivity(new Intent(Intent.ACTION_VIEW,
                            Uri.parse("https://play.google.com/store/apps/details?id=" + appId)));
                }
            }
            result.success(null);
        }  else {
            result.notImplemented();
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        register(this, binding.getBinaryMessenger(), null);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
