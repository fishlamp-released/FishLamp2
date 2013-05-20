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
@end

@interface GtApplicationDelegate : UIResponder<GtNotificationDisplayManager, GtUserSessionDelegate> {
@private
	UIWindow* m_window;
}

@property (readwrite, retain, nonatomic) IBOutlet UIWindow *window;

+ (id) instance;

- (void) initializeAppWithTheme:(GtMobileTheme*) theme;

- (void) openAppWithDefaultUser:(GtBlock) userLoginCompleted;

- (void) logout;
- (void) beginLoggingOut;

// call this after initializeApp.
- (GtNavigationController*) createNavigationControllerInRootViewController;

// this is called if the window doesn't have a root view controller after it's loaded.
- (UIViewController*) createRootViewController; // returns a new GtApplicationRootViewController by default


// optional overrides
- (void) userSessionWillOpen:(GtUserSession*) userSession;
- (void) userSessionDidOpen:(GtUserSession*) userSession;
- (void) userSessionDidClose:(GtUserSession*) userSession;
- (void) userSessionUserDidLogout:(GtUserSession*) userSession;
- (void) userSession:(GtUserSession*) userSession appVersionWillChange:(GtVersionUpgradeLengthyTaskList*) taskListToAddTo;
@end
