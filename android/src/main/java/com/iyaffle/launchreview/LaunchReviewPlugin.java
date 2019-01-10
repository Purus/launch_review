package com.iyaffle.launchreview;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.Intent;
import android.net.Uri;
import android.content.ActivityNotFoundException;

/**
 * LaunchReviewPlugin
 */
public class LaunchReviewPlugin implements MethodCallHandler {

  private final Registrar mRegistrar;

  private LaunchReviewPlugin(Registrar registrar) {
    this.mRegistrar = registrar;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "launch_review");
    LaunchReviewPlugin instance = new LaunchReviewPlugin(registrar);
    channel.setMethodCallHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("launch")) {
      String appPackageName = call.argument("android_id");

      if (appPackageName == null) {
        appPackageName = mRegistrar.activity().getPackageName();
      }

      try {
          mRegistrar.activity().startActivity(new Intent(Intent.ACTION_VIEW,
              Uri.parse("market://details?id=" + appPackageName)));
      } catch (ActivityNotFoundException e) {
          mRegistrar.activity().startActivity(new Intent(Intent.ACTION_VIEW,
              Uri.parse("https://play.google.com/store/apps/details?id=" + appPackageName)));
      }

      result.success(null);
    } else {
      result.notImplemented();
    }
  }
}
