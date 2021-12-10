import 'package:flutter/services.dart';

class LaunchReview {
  static const MethodChannel _channel = const MethodChannel('launch_review');

  /// Note: It will not work with the iOS Simulator.
  ///
  /// Set writeReview to false to only show the app store page. Used only in iOS.
  static Future<void> launch(
      {String? androidAppId,
      String? iOSAppId,
      String? toastMessage,
      bool writeReview = true,
      bool showToast = true,
      bool isiOSBeta = false}) async {
    await _channel.invokeMethod('launch', {
      'android_id': androidAppId,
      'ios_id': iOSAppId,
      'write_review': writeReview,
      'is_ios_beta': isiOSBeta,
      'toast_message': toastMessage,
      'show_toast': showToast
    });
  }
}
