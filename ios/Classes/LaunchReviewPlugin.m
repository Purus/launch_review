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
        NSString *appId = call.arguments[@"ios_id"] ? : [self fetchAppIdFromBundleId];

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
              iTunesLink = [NSString stringWithFormat:@"https://apps.apple.com/app/id%@?action=write-review", appId];
            } else {
              iTunesLink = [NSString stringWithFormat:@"https://apps.apple.com/app/id%@", appId];
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

- (NSString *)fetchAppIdFromBundleId
{
    NSString* bundleId = [NSBundle mainBundle].bundleIdentifier;
    NSString* iTunesServiceURL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", bundleId];

    NSString* errorMsg = nil;
    NSNumber* appStoreId = nil;
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSURL *url = [NSURL URLWithString:iTunesServiceURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSInteger resultCount = [jsonData[@"resultCount"] intValue];
    NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;

    if (resultCount > 0 && statusCode == 200){
        if (!error){
            appStoreId = jsonData[@"results"][0][@"trackId"];
        }else{
            errorMsg = [error localizedDescription];
        }
    }else if (statusCode >= 400){
        //http error
        errorMsg = [NSString stringWithFormat:@"The server returned a %@ error", @(statusCode)];
    }else{
        errorMsg = @"The application could not be found on the App Store.";
    }

    if(errorMsg != nil){
        NSLog(@"%@", errorMsg);
    }

    return [appStoreId stringValue];
}

@end
