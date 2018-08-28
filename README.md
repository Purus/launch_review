# store_redirect

[![pub package](https://img.shields.io/pub/v/store_redirect.svg)](https://pub.dartlang.org/packages/store_redirect)

A Flutter plugin to redirect users to an app page in Google Play Store and Apple App Store.

The implementation is a fork of: https://github.com/Purus/launch_review

------------------------------

> *NOTE:* Please feel free to send a PR to add more functionalities.

Thanks to [Edouard Marquez](https://github.com/g123k) for adding the iOS functionality.

## Usage
To use this plugin, add `store_redirect` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Example

Import the library via
``` dart
import 'package:store_redirect/store_redirect.dart'; 
```

Then invoke the static `redirect` method of `StoreRedirect` anywhere in your Dart code. If no arguments are provided, it will consider the current package.

``` dart
StoreRedirect.redirect();
```

To open the App Store page for any other applications, you can pass the app Id.

``` dart
StoreRedirect.redirect(androidAppId: "com.iyaffle.rangoli",
                    iOSAppId: "585027354");
```

This plugin is inspired by the Cordova plugin [cordova-launch-review](https://github.com/dpa99c/cordova-launch-review) created by dpa99c.

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
