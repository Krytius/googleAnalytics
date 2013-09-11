#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "GANTracker.h"

@interface GoogleAnalyticsPlugin : CDVPlugin <GANTrackerDelegate> {}

- (void)startTrackerWithAccountID:(CDVInvokedUrlCommand*)command;
- (void)trackEvent:(CDVInvokedUrlCommand*)command;
- (void)setCustomVariable:(CDVInvokedUrlCommand*)command;
- (void)trackPageview:(CDVInvokedUrlCommand*)command;

@end