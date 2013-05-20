//
//  GtApplication.m
//  MyZen
//
//  Created by Mike Fullerton on 12/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtApplication.h"
#import "GtUtilities.h"
#import "GtDefaultErrorHandler.h"
#import "GtWindow.h"
#import "GtDefaultUserNotificationErrorFormatters.h"
#import "GtCachedAuthenticationToken.h"

@implementation GtApplication

GtSynthesize(window, setWindow, UIWindow, m_window);
@synthesize navigationController = m_navigationController;

static GtApplication* s_instance = nil;

+ (GtApplication*) instance
{
	return s_instance;
}

- (void) onUserLoggedOut:(id) sender
{
}

- (void) onConnectFishlampObjects
{
	[GtUtilities initializeFishLamp];
	[GtDatabaseCache setInitializer:self];

	[[GtDefaultErrorHandler instance] becomeDefaultHandler];
	
	[GtActionErrorHandler instance].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
			selector: @selector(onUserLoggedOut:) 
			name: GtUserSessionUserLoggedOutNotification object: [UIApplication sharedApplication]];

}

- (void) onInitNetworking
{
}

- (void) onInitErrorHandling
{
    InstallDefaultUserNotificationErrorFormatters();
}

- (void) onInitUI
{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];	
    [m_window makeKeyAndVisible];
}

- (void) onInitComplete
{
}

- (void)dealloc 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
    GtRelease(m_navigationController);
   	GtRelease(m_window);
	[super dealloc];
}

- (void) onStartApplication
{
}

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	s_instance = self;
	
	GtAssertNotNil(m_window);
	GtAssert([m_window isKindOfClass:[GtWindow class]], 
		@"Expecting application window to be a GtWindow. You can change this in Interface Builder.");
	
	[self onConnectFishlampObjects];
    [self onInitErrorHandling];
	[self onInitNetworking];
	[self onInitUI];
	[self onInitComplete];

    [self onStartApplication];
	
#if GT_MEMORY_MONITOR	
	[[GtMemoryMonitor instance] start:m_window];	
#endif	
}

- (void) databaseCacheSetCacheBehaviors:(GtDatabaseCache*) cache
{
	[cache setCacheBehaviorForClass:
		[GtDatabaseCacheBehavior cacheBehavior: GtHourInterval
        allowStaleDataInCache:NO 
        touchOnAccess:NO
        maxCachedInMemory:0]
		forClass:[GtCachedAuthenticationToken class]];
}

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 attemptToRetryOnNetworkError:(GtAction*) action
	 reachability:(GtReachability*) reachability
{

	return NO;
}

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 reportErrorForAction:action
	 userNotificationView:(GtUserNotificationView*) view
{
	return NO;
}

- (void) showNetworkActivityIndicator
{
	@synchronized(self)
	{
		if(++m_networkActivityCounter == 1)
		{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		}
	}
}

- (void) doHideActivityMonitor:(id) sender
{
	@synchronized(self)
	{
		if(--m_networkActivityCounter == 0)
		{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		}	
	}
}

- (void) hideNetworkActivityIndicator
{
	@synchronized(self)
	{
		[self performSelectorOnMainThread:@selector(doHideActivityMonitor:) withObject:nil waitUntilDone:NO];
	}
}

- (void) createNavigationController:(UIViewController*) rootController 
                              style:(UIBarStyle) style
{
    GtAssertNil(m_navigationController);
    
    m_navigationController = [GtAlloc(UINavigationController) initWithRootViewController:rootController];
    m_navigationController.navigationBar.barStyle = style;
    m_navigationController.wantsFullScreenLayout = YES;
    
  	[self.window addSubview:m_navigationController.view];	
}



@end
