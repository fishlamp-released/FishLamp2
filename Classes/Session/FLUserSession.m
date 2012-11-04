//
//	FLUserSession.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserSession.h"
#import "FLLowMemoryHandler.h"
#import "FLApplicationDataVersion.h"
#import "FLApplicationDataModel.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserDataStorageService.h"


@interface FLUserSession ()
@property (readwrite, strong) FLUserLogin* userLogin; 
@property (readwrite, strong) FLBackgroundTaskMgr* backgroundTasks;
@property (readwrite, strong) FLUserDataStorageService* dataService;
@end

@implementation FLUserSession

@synthesize userLogin = _login;

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

- (void) dealloc {
#if FL_MRC
    [_userLogin release]'
    [super dealloc];
#endif
}

- (BOOL) isSessionOpen {
	return self.dataService != nil;
}	 

- (void) closeSession {
	
    [self postObservation:@selector(userSessionWillClose:)];
    [super closeSession];
    [self postObservation:@selector(userSessionDidClose:)];

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

- (void) openSession {
    FLAssert_v(!self.isSessionOpen, @"session already open");
    FLAssert_v(FLStringIsNotEmpty(self.userLogin.userName), @"invalid userLogin");

    [self postObservation:@selector(userSessionWillOpen:)];
    [super openSession];
    [self postObservation:@selector(userSessionDidOpen:)];
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

