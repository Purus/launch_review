package com.danieldallos.storeredirect;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.Intent;
import android.net.Uri;

/**
 * StoreRedirectPlugin
 */
public class StoreRedirectPlugin implements MethodCallHandler {

  private final Registrar mRegistrar;

  private StoreRedirectPlugin(Registrar registrar) {
    this.mRegistrar = registrar;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "store_redirect");
    StoreRedirectPlugin instance = new StoreRedirectPlugin(registrar);
    channel.setMethodCallHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("redirect")) {

      String appId = (String) call.argument("android_id");
      String appPackageName;

      if (appId != null) {
        appPackageName = appId;
      } else {
        appPackageName = mRegistrar.activity().getPackageName();
      }

      Intent marketIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=" + appPackageName));
      marketIntent.addFlags(
          Intent.FLAG_ACTIVITY_NO_HISTORY | Intent.FLAG_ACTIVITY_NEW_DOCUMENT | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
      mRegistrar.activity().startActivity(marketIntent);

      result.success(null);
    } else {
      result.notImplemented();
    }
  }
}
