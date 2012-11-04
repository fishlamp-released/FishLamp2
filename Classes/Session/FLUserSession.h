//
//	FLUserSession.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLUserLogin.h"
#import "FLService.h"
#import "FLServiceGroup.h"
#import "FLBackgroundTaskMgr.h"
#import "FLServiceGroup.h"
#import "FLVersionUpgradeLengthyTaskList.h"

@protocol FLUserSession <FLServiceGroup>
@property (readonly, strong) FLUserLogin* userLogin; 
@end

@interface FLUserSession : FLServiceGroup<FLUserSession> {
@private
	FLUserLogin* _userLogin;
}

- (id) initWithUserLogin:(FLUserLogin*) userLogin;

@property (readonly, assign) BOOL isSessionOpen;
@property (readwrite, assign, getter=isAuthenticated) BOOL authenticated;

+ (FLUserLogin*) loadLastUserLogin;
+ (FLUserLogin*) loadDefaultUser;
@end

@protocol FLUserSessionObserver <FLObserver>
@optional
- (void) userSessionWillOpen:(id<FLUserSession>) userSession;
- (void) userSessionDidOpen:(id<FLUserSession>) userSession;
- (void) userSessionWillClose:(id<FLUserSession>) userSession;
- (void) userSessionDidClose:(id<FLUserSession>) userSession;
@end


// app services
