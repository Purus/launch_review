# launch_review

[![pub package](https://img.shields.io/pub/v/launch_review.svg)](https://pub.dartlang.org/packages/launch_review)

A Flutter plugin for Android to assist in leaving user reviews/ratings in the Google Play Store.

*NOTE:* Please feel free to send a PR for adding iOS functionality. I do not have a Mac and so can not work on the iOS part of the plugin.

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

To open the Play Store page for other App, you can pass the package Id of the app.

``` dart
LaunchReview.launch("com.iyaffle.myapp");
```

This plugin is inspired by the Cordova plugin [cordova-launch-review](https://github.com/dpa99c/cordova-launch-review) created by dpa99c.

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.