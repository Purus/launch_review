# launch_review

[![pub package](https://img.shields.io/pub/v/launch_review.svg)](https://pub.dartlang.org/packages/launch_review)

A Flutter plugin to assist in leaving user reviews/ratings in Google Play Store and Apple App Store.

> *NOTE:* Please feel free to send a PR to add more functionalities.

### iOS
Thanks to [Edouard Marquez](https://github.com/g123k) for adding the iOS functionality.

For iOS 9 and above, your `Info.plist` file  __MUST__ have the following:
```
<key>LSApplicationQueriesSchemes</key>
<array>
        <string>itms-beta</string>
        <string>itms</string>
</array>
```

## Usage
To use this plugin, add `launch_review` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Example

Import the library via
``` dart
import 'package:launch_review/launch_review.dart'; 
```

Then invoke the static `launch` method of `LaunchReview` anywhere in your Dart code. If no arguments are provided, it will consider the current package.

``` dart
LaunchReview.launch();
```

To open the App Store page for any other applications, you can pass the app Id.

``` dart
LaunchReview.launch(androidAppId: "com.iyaffle.rangoli",
                    iOSAppId: "585027354");
```

This plugin is inspired by the Cordova plugin [cordova-launch-review](https://github.com/dpa99c/cordova-launch-review) created by dpa99c.

## iOS Specifics
Set writeReview to false to only show the app store page. Used only in iOS.

``` dart
LaunchReview.launch(writeReview: false,iOSAppId: "585027354");
```

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
