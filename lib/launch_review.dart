import 'dart:async'; 

import 'package:flutter/services.dart'; 

class LaunchReview {
  static const MethodChannel _channel = 
      const MethodChannel('launch_review'); 

  static Future <void> launch(String appId) => 
      _channel.invokeMethod('launch',appId); 
}
