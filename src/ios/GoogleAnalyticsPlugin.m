#import "GoogleAnalyticsPlugin.h"


@implementation GoogleAnalyticsPlugin

- (void) startTrackerWithAccountID:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* accountId = [command.arguments objectAtIndex:0];
    
    // Connect Analytcs
    [[GANTracker sharedTracker] startTrackerWithAccountID:accountId dispatchPeriod:10 delegate:self];
    
    // Callback
    if ([GANTracker sharedTracker]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@%@", @"Connect to account ", accountId]];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"%@%@", @"Don't Connect to account ", accountId]];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) trackEvent:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* category = [command.arguments valueForKey:@"category"];
    NSString* action = [command.arguments valueForKey:@"action"];
    NSString* label = [command.arguments valueForKey:@"label"];
    int value = [[command.arguments valueForKey:@"value"] intValue];
    
    NSError *error;
    
    if (![[GANTracker sharedTracker] trackEvent:category action:action label:label value:value withError:&error]) {
        // Handle error here
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"GoogleAnalyticsPlugin.trackEvent Error:",[error localizedDescription]]];
    } else {
        // Handle success
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"GoogleAnalyticsPlugin.trackEvent::%@, %@, %@, %d",category,action,label,value]];
    }
    //Callback
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) setCustomVariable:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    int index = [[command.arguments valueForKey:@"index"] intValue];
    NSString* name = [command.arguments valueForKey:@"name"];
    NSString* value = [command.arguments valueForKey:@"value"];
    
    NSError *error;
    
    if (![[GANTracker sharedTracker] setCustomVariableAtIndex:index name:name value:value withError:&error]) {
        // Handle error here
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"GoogleAnalyticsPlugin.setCustomVariable Error:",[error localizedDescription]]];
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"GoogleAnalyticsPlugin.setCustomVariable::%d, %@, %@", index, name, value]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) trackPageview:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* pageUri = [command.arguments objectAtIndex:0];
    NSError *error;
    if (![[GANTracker sharedTracker] trackPageview:pageUri withError:&error]) {
        // TODO: Handle error here
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"Error GoogleAnalyticsPlugin.trackView:",[error localizedDescription]]];
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@%@",@"Success GoogleAnalyticsPlugin.trackView: ", pageUri]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) hitDispatched:(NSString *)hitString
{
    NSString* callback = [NSString stringWithFormat:@"window.plugins.googleAnalyticsPlugin.hitDispatched(%d);", hitString];
    [ self.webView stringByEvaluatingJavaScriptFromString:callback];
    
}

- (void) trackerDispatchDidComplete:(GANTracker *)tracker eventsDispatched:(NSUInteger)hitsDispatched eventsFailedDispatch:(NSUInteger)hitsFailedDispatch
{
    NSString* callback = [NSString stringWithFormat:@"window.plugins.googleAnalyticsPlugin.trackerDispatchDidComplete(%d);",
                          hitsDispatched];
    [ self.webView stringByEvaluatingJavaScriptFromString:callback];
    
}

- (void) dealloc
{
    [[GANTracker sharedTracker] stopTracker];
}

@end