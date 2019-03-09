import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Launch App Review')),
        body: Center(
          child: RaisedButton(
            child: Text("Rate App"),
            onPressed: () => LaunchReview.launch(
              androidAppId: "com.iyaffle.kural",
              iOSAppId: "585027354",
            ),
          ),
        ),
      ),
    );
  }
}
