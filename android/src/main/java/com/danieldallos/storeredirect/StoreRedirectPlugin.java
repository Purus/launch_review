package com.danieldallos.storeredirect;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;

/**
 * StoreRedirectPlugin
 */
public class StoreRedirectPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {

  private Activity activity;
  private MethodChannel methodChannel;

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    StoreRedirectPlugin instance = new StoreRedirectPlugin();
    instance.onAttachedToEngine(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    onAttachedToEngine(binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
    methodChannel = null;
  }

  private void onAttachedToEngine(BinaryMessenger messenger) {
    methodChannel = new MethodChannel(messenger, "store_redirect");
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("redirect")) {

      String appId = (String) call.argument("android_id");
      String appPackageName;

      if (appId != null) {
        appPackageName = appId;
      } else {
        appPackageName = this.activity.getPackageName();
      }

      Intent marketIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=" + appPackageName));
      marketIntent.addFlags(
          Intent.FLAG_ACTIVITY_NO_HISTORY | Intent.FLAG_ACTIVITY_NEW_DOCUMENT | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
      this.activity.startActivity(marketIntent);

      result.success(null);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }
}
