//
//	FLUserLoginService.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserLoginService.h"
#import "FLLowMemoryHandler.h"
#import "FLApplicationDataVersion.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLService.h"


@interface FLUserLoginService ()
@property (readwrite, assign, getter=isAuthenticated) BOOL authenticated;
@end

@implementation FLUserLoginService

+ (id) userLoginService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) closeService:(FLServiceManager*) context {
    
//    [self postObservation:@selector(userSessionWillClose:)];
//    [super closeContext];
//    [self postObservation:@selector(userSessionDidClose:)];

//    id<FLProgressViewController> progress = nil;
//    
//    if([self.backgroundTasks isExecutingBackgroundTask]) {
//        progress = [[self class] createUserLoggingOutProgressViewController];
//        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
//    }
//
//    [self.backgroundTasks beginClosingService:^(FLFinisher* backgroundTaskMgr) {
//        [self closeContext];
//        [progress hideProgress];
//        [asyncTask setFinished];
//    }];
    
//	if(self.isContextOpen) {
//		[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
//	}
//	 
//	@try {
//        _login.isAuthenticatedValue = NO;
//        [[FLApplicationDataModel instance] saveUserLogin:_login];
//    
//		[_cacheDatabase closeDatabase];
//		[_documentsDatabase closeDatabase];
//
//		// wtf to do if db close fails???? 
//	}
//	@finally {
//		[self deleteSessionData];
//
//		FLAssertIsNil_v(_cacheDatabase, nil);
//		FLAssertIsNil_v(_documentsDatabase, nil);
//		
//		_state.open = NO;
//		_state.willOpen = NO;
//		_state.isOpening = NO;
//		
//    }
}

- (void) openService:(FLServiceManager*) context {
//    FLAssert_v(!self.isContextOpen, @"session already open");
//    FLAssert_v(FLStringIsNotEmpty(self.userLogin.userName), @"invalid userLogin");

//    [self postObservation:@selector(userSessionWillOpen:)];
//    [super openService];
//    [self postObservation:@selector(userSessionDidOpen:)];
}

- (void) saveUserLogin {
//    [[FLApplicationDataModel instance] saveUserLogin:[self.context userLogin]];
}

- (BOOL) isAuthenticated {
return NO;
//	return [self.context userLogin].isAuthenticatedValue;
}

- (void) setAuthenticated:(BOOL) authenticated {
//    [self.context userLogin].isAuthenticatedValue = authenticated;
//    [[FLApplicationDataModel instance] saveUserLogin:[self.context userLogin]];
}

+ (FLUserLogin*) loadLastUserLogin {

return nil;
//	return [[FLApplicationDataModel instance] loadLastUserLogin];
}

+ (FLUserLogin*) loadDefaultUser {
//	FLUserLogin* login = [[FLApplicationDataModel instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
//    if(!login) {
//        login = [FLUserLogin userLogin];
//        login.userName = NSLocalizedString(@"Guest", nil);
//        login.isAuthenticatedValue = YES;
//        login.userGuid = [NSString zeroGuidString];
//        [[FLApplicationDataModel instance] saveUserLogin:login];
//        [[FLApplicationDataModel instance] setCurrentUser:login];
//    }
//	return login;

    return nil;
}

@end



