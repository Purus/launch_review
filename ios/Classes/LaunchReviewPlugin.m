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
        if (!appId.length) {
            result([FlutterError errorWithCode:@"ERROR"
                                       message:@"Invalid app id"
                                       details:nil]);
        } else {
            NSString* iTunesLink;
            if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
                iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/xy/app/foo/id%@?action=write-review", appId];
            } else {
                iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&action=write-review", appId];
            }
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
            
            result(nil);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
