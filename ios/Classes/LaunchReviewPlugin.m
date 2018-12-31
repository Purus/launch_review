#import "LaunchReviewPlugin.h"

@implementation LaunchReviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"launch_review"
                                     binaryMessenger:[registrar messenger]];
    LaunchReviewPlugin* instance = [[LaunchReviewPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"launch" isEqualToString:call.method]) {
        NSString *appId = call.arguments[@"ios_id"];

        if (appId == (NSString *)[NSNull null]) {
            result([FlutterError errorWithCode:@"ERROR"
                                     message:@"App id cannot be null"
                                     details:nil]);
        } else if ([appId length] == 0) {
            result([FlutterError errorWithCode:@"ERROR"
                                     message:@"Empty app id"
                                     details:nil]);
        } else {
            NSString *iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appId];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];

            result(nil);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
