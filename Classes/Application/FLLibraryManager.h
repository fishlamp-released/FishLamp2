//
//  FLApplicationDelegate.h
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLUserSession.h"
#import "FLVersionUpgradeLengthyTaskList.h"
@class FLTheme;

@protocol FLLibraryManagerDelegate;

@interface FLLibraryManager : NSObject<FLUserSessionDelegate> {
@private
    id<FLLibraryManagerDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLLibraryManagerDelegate> delegate;

FLSingletonProperty(FLLibraryManager);

- (void) initializeAppWithTheme:(FLTheme*) defaultTheme;

- (void) openAppWithDefaultUser:(FLEventCallback) userLoginCompleted;

- (void) beginLoggingOutUser;

@end

@protocol FLLibraryManagerDelegate <NSObject>

@optional

- (void) willLogoutUser:(FLLibraryManager*) manager;

- (void) userSessionWillOpen:(FLUserSession*) userSession;
- (void) userSessionDidOpen:(FLUserSession*) userSession;
- (void) userSessionDidClose:(FLUserSession*) userSession;
- (void) userSessionUserDidLogout:(FLUserSession*) userSession;
- (void) userSession:(FLUserSession*) userSession appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;
@end



