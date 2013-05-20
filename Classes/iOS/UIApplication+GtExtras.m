//
//	UIApplication+GtExtras.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIApplication+GtExtras.h"
#import "GtNetworkActivityIndicator.h"
#import "GtDefaultUserNotificationErrorFormatters.h"
#import "GtWebViewController.h"
#import "GtUncaughtExceptionHandler.h"
#import "GtLowMemoryHandler.h"
#import "NSFileManager+GtExtras.h"
#import "GtErrorDisplayManager.h"
#import "GtMobileNotificationDisplayManager.h"
#import "GtKeyboardManager.h"


#if __GT_MEMORY_MONITOR 
#import "GtMemoryMonitor.h"
#endif

#if UNIT_TESTS
#import "GtUnitTestManager.h"
#endif
#import "GtWebViewController.h"

#if __GT_MEMORY_MONITOR 
#import "GtMemoryMonitor.h"
#endif

#if UNIT_TESTS
#import "GtUnitTestManager.h"
#endif

@implementation UIApplication (GtExtras)


- (BOOL) openUrlInSafari:(NSURL*) url errorMessage:(NSString*) errorMessage
{
	if( ![[UIApplication sharedApplication] canOpenURL:url] ||
	   ![[UIApplication sharedApplication] openURL:url])
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Unable to open URL", nil)
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:nil
											  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
		[alert show];
		GtRelease(alert);
		
		return NO;
	}
	
	return YES;
}



@end
