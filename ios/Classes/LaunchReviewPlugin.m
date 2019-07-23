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
            NSString *iTunesLink;
            if ([call.arguments[@"write_review"] boolValue]) {
              iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appId];
            } else {
              iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
            }
            
            if ([call.arguments[@"is_ios_beta"] boolValue]) {
              NSURL *customAppURL = [NSURL URLWithString:@"itms-beta://"];
              if ([[UIApplication sharedApplication] canOpenURL:customAppURL]) {
                  
                  // TestFlight is installed
                  
                  // Special link that includes the app's Apple ID
                  iTunesLink = [NSString stringWithFormat:@"itms-beta://beta.itunes.apple.com/v1/app/id%@", appId];
                  NSURL* itunesURL = [NSURL URLWithString:iTunesLink];

                  if ([[UIApplication sharedApplication] canOpenURL:itunesURL]) {
                    [[UIApplication sharedApplication] openURL:itunesURL];
                  }
                  result(nil);
              }
            }

            NSURL* itunesURL = [NSURL URLWithString:iTunesLink];
            if ([[UIApplication sharedApplication] canOpenURL:itunesURL]) {
              [[UIApplication sharedApplication] openURL:itunesURL];
            }

            result(nil);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
