import 'dart:async';

import 'package:flutter/services.dart';

class LaunchReview {
  static const MethodChannel _channel = const MethodChannel('launch_review');

  /// Note: It will not work with the iOS Simulator
  static Future<void> launch({String androidAppId, String iOSAppId}) async {
    await _channel.invokeMethod(
        'launch', {'android_id': androidAppId, 'ios_id': iOSAppId});
    return null;
  }
}
