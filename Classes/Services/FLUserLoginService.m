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
#import "FLApplicationDataModel.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserDataStorageService.h"
#import "FLSession.h"

register_service_(userService, FLUserLoginService);

@interface FLUserLoginService ()
@property (readwrite, assign, getter=isAuthenticated) BOOL authenticated;
@property (readwrite, strong) FLUserLogin* _userLogin;
@end

@implementation FLUserLoginService

@synthesize _userLogin = _userLogin;

- (id) initWithUserLogin:(FLUserLogin*) userLogin {
    self = [super init];
    if(self) {
        self.userLogin = userLogin;
    }
    
    return self;
}

- (id) init {
	return [self initWithUserLogin:nil];
}

dealloc_(
    [_userLogin release];
)

- (void) closeService {
	[super closeService];
    
//    [self postObservation:@selector(userSessionWillClose:)];
//    [super closeSession];
//    [self postObservation:@selector(userSessionDidClose:)];

//    id<FLProgressViewController> progress = nil;
//    
//    if([self.backgroundTasks isExecutingBackgroundTask]) {
//        progress = [[self class] createUserLoggingOutProgressViewController];
//        [progress setTitle:NSLocalizedString(@"Logging Out…", nil)];
//    }
//
//    [self.backgroundTasks beginClosingService:^(id<FLResult> backgroundTaskMgr) {
//        [self closeSession];
//        [progress hideProgress];
//        [finisher setFinished];
//    }];
    
//	if(self.isSessionOpen) {
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

- (void) openService {
//    FLAssert_v(!self.isSessionOpen, @"session already open");
//    FLAssert_v(FLStringIsNotEmpty(self.userLogin.userName), @"invalid userLogin");

//    [self postObservation:@selector(userSessionWillOpen:)];
    [super openService];
//    [self postObservation:@selector(userSessionDidOpen:)];
}

- (FLUserLogin*) userLogin {
    return self._userLogin;
}

- (void) setUserLogin:(FLUserLogin*) userLogin {
    self._userLogin = userLogin;
    [[FLApplicationDataModel instance] saveUserLogin:self.userLogin];
}

- (BOOL) isAuthenticated {
	return self.userLogin.isAuthenticatedValue;
}

- (void) setAuthenticated:(BOOL) authenticated {
    self.userLogin.isAuthenticatedValue = authenticated;
    [[FLApplicationDataModel instance] saveUserLogin:self.userLogin];
}

+ (FLUserLogin*) loadLastUserLogin {
	return [[FLApplicationDataModel instance] loadLastUserLogin];
}

+ (FLUserLogin*) loadDefaultUser {
	FLUserLogin* login = [[FLApplicationDataModel instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
    if(!login) {
        login = [FLUserLogin userLogin];
        login.userName = NSLocalizedString(@"Guest", nil);
        login.isAuthenticatedValue = YES;
        login.userGuid = [NSString zeroGuidString];
        [[FLApplicationDataModel instance] saveUserLogin:login];
        [[FLApplicationDataModel instance] setCurrentUser:login];
    }
	return login;
}

@end


@implementation FLOperation (ZFUserSession)
- (FLUserLogin*) userLogin {
    return [self.services userService].userLogin;
}
@end
