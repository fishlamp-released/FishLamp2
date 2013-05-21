//
//  GtApplicationDelegate.h
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtNavigationController.h"
#import "GtErrorDisplayManager.h"
#import "GtViewController.h"
#import "GtUserSession.h"
#import "GtVersionUpgradeLengthyTaskList.h"
#import "GtMobileTheme.h"

@interface GtApplicationRootViewController : GtViewController 
+ (id) applicationRootViewController;
@end

@interface GtApplicationDelegate : UIResponder<GtNotificationDisplayManager, GtUserSessionDelegate> {
@private
	UIWindow* m_window;
    GtNavigationController* _navigationController;
}

@property (readwrite, retain, nonatomic) IBOutlet UIWindow *window;
@property (readwrite, retain, nonatomic) GtNavigationController* navigationController;

+ (id) instance;

- (void) initializeAppWithTheme:(GtMobileTheme*) theme;

- (void) openAppWithDefaultUser:(GtBlock) userLoginCompleted;

- (void) logout;
- (void) beginLoggingOut;

- (void) setRootViewController:(UIViewController*) rootViewController;
- (void) setRootViewControllerWithNavigationController;
- (void) setRootViewControllerWithNavigationController:(UIViewController*) rootViewController;


// optional overrides
- (void) userSessionWillOpen:(GtUserSession*) userSession;
- (void) userSessionDidOpen:(GtUserSession*) userSession;
- (void) userSessionDidClose:(GtUserSession*) userSession;
- (void) userSessionUserDidLogout:(GtUserSession*) userSession;
- (void) userSession:(GtUserSession*) userSession appVersionWillChange:(GtVersionUpgradeLengthyTaskList*) taskListToAddTo;
@end
