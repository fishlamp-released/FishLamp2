//
//  GtApplication.h
//  MyZen
//
//  Created by Mike Fullerton on 12/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserNotificationView.h"
#import "GtActionErrorHandler.h"
#import "GtDatabaseCache.h"

#import "GtAction.h"

#import "GtReachability.h"

#import "GtUserSession.h"
#import "GtWindow.h"


@interface GtApplication : NSObject < 	UIApplicationDelegate, 
										GtActionErrorHandlerDelegate,
										GtDatabaseCacheInitializer> {
@private
	IBOutlet GtWindow* m_window;
    IBOutlet UINavigationController* m_navigationController;
	
	int m_networkActivityCounter;
}

@property (readonly, assign, nonatomic) GtWindow* window;
@property (readonly, assign, nonatomic) UINavigationController* navigationController;

+ (GtApplication*) instance;


@end

@interface GtApplication (Protected)

// for initialize app
- (void) onConnectFishlampObjects;
- (void) onInitErrorHandling;
- (void) onInitNetworking;
- (void) onInitUI;
- (void) onInitComplete;
- (void) onStartApplication;

- (void) createNavigationController:(UIViewController*) rootController 
                              style:(UIBarStyle) style;

// Action error handling

- (void) onUserLoggedOut:(id) sender;

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 attemptToRetryOnNetworkError:(GtAction*) action
	 reachability:(GtReachability*) reachability;

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 reportErrorForAction:action
	 userNotificationView:(GtUserNotificationView*) view;

// database cache

- (void) databaseCacheSetCacheBehaviors:(GtDatabaseCache*) cache;

- (void) showNetworkActivityIndicator;
- (void) hideNetworkActivityIndicator;


@end
