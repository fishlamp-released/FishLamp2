//
//  FLHttpRequestAuthenticator.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticator.h"
#import "FLHttpRequest.h"
#import "FLReachableNetwork.h"

@interface FLHttpRequestAuthenticator ()
@end

@implementation FLHttpRequestAuthenticator
@synthesize userLogin = _userLogin;
@synthesize lastAuthenticationTimestamp = _lastAuthenticationTimestamp;
@synthesize timeoutInterval = _timeoutInterval;

- (id) initWithContext:(id) context authenticationTimeout:(NSTimeInterval) timeoutInterval {
    self = [super init];
    if(self) {
        _timeoutInterval = timeoutInterval;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_userLogin release];
    [super dealloc];
}
#endif

- (void) setUserLogin:(FLUserLogin*) userLogin {
    FLSetObjectWithRetain(_userLogin, userLogin);
    [self resetAuthenticationTimestamp];
}

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLUserLogin*) userLogin {
}           

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin {
    return nil;
}

- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin {
    return userLogin.isAuthenticatedValue;
}

- (BOOL) shouldAuthenticateUser:(FLUserLogin*) userLogin {
	
    if( _lastAuthenticationTimestamp != 0.0f && 
        _lastAuthenticationTimestamp > [NSDate timeIntervalSinceReferenceDate]) {
		return NO;
	}

	FLAssertIsNotNil_(userLogin);
	return ![self userLoginIsAuthenticated:userLogin];
}

- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest {
    FLUserLogin* userLogin = self.userLogin;
    if([self shouldAuthenticateUser:userLogin]) {
        [self resetAuthenticationTimestamp];

        userLogin = [self synchronouslyAuthenticateUser:userLogin];
        self.userLogin = userLogin;

        [self touchAuthenticationTimestamp];
    }
    [self authenticateHttpRequest:httpRequest withAuthenticatedUser:userLogin];
}

- (BOOL) isAuthenticated {
    return self.userLogin && ![self shouldAuthenticateUser:self.userLogin];
}

- (void) touchAuthenticationTimestamp {
    _lastAuthenticationTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) resetAuthenticationTimestamp {
	_lastAuthenticationTimestamp = 0;
}

@end