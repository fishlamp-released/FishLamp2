//
//	FLUserLoginService.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLUserLogin.h"
#import "FLService.h"

@interface FLUserLoginService : FLService {
@private
}
@property (readonly, assign, getter=isAuthenticated) BOOL authenticated;

- (void) saveUserLogin;

+ (FLUserLogin*) loadLastUserLogin;
+ (FLUserLogin*) loadDefaultUser;
@end

//@protocol FLUserSessionObserver <FLObserver>
//@optional
//- (void) userSessionWillOpen:(id<FLUserLoginService>) userSession;
//- (void) userSessionDidOpen:(id<FLUserLoginService>) userSession;
//- (void) userSessionWillClose:(id<FLUserLoginService>) userSession;
//- (void) userSessionDidClose:(id<FLUserLoginService>) userSession;
//@end

service_declare_(userService, FLUserLoginService);