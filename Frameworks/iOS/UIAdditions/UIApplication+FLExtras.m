//
//	UIApplication+FLExtras.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIApplication+FLExtras.h"
#import "FLNetworkActivityIndicator.h"
#import "FLDefaultUserNotificationErrorFormatters.h"
#import "FLWebViewController.h"
#import "FLUncaughtExceptionHandler.h"
#import "FLLowMemoryHandler.h"
#import "NSFileManager+FLExtras.h"
#import "FLKeyboardManager.h"
#import "FLViewController.h"
#import "FLViewControllerStack.h"
#import "FLAlert.h"
#import "FLButtons.h"
#import "FLWebViewController.h"

#if __FL_MEMORY_MONITOR 
#import "FLMemoryMonitor.h"
#endif

#if TEST
#endif

#if __FL_MEMORY_MONITOR 
#import "FLMemoryMonitor.h"
#endif



@implementation UIApplication (FLExtras)

- (BOOL) openUrlInSafari:(NSURL*) url errorMessage:(NSString*) errorMessage {
	if( ![[UIApplication sharedApplication] canOpenURL:url] ||
	   ![[UIApplication sharedApplication] openURL:url]) {
		FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Unable to open URL", nil)
                                                
        message:errorMessage];

        [alert addButton:[FLConfirmButton okButton]];
        [alert showViewControllerAnimated:YES];
		
		return NO;
	}
	
	return YES;
}

+ (UIViewController*) visibleViewController {
    UIViewController* controller = nil;

	if([FLViewController isPresentingModalViewController]) {
		controller = [FLViewController presentingModalViewController].modalViewController;
    }
    else {
        controller = [[UIApplication sharedApplication].delegate window].rootViewController;
    }
    
    controller = [controller visibleViewController];
    
    return controller;
}

@end
