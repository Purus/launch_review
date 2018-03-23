import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Launch App Review')),
            body: new Center(
                child: new RaisedButton(
                    child: new Text("Rate App"),
                    onPressed: () {
                      LaunchReview.launch(androidAppId: "com.iyaffle.rangoli", iOSAppId: "585027354");
                    }))));
  }
}
