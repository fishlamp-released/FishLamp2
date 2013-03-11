//
//  FLHttpRequestAuthenticationService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticationService.h"
#import "FLHttpRequest.h"
#import "FLReachableNetwork.h"
#import "FLDispatch.h"

@interface FLHttpRequestAuthenticationService ()
@end

@implementation FLHttpRequestAuthenticationService

@synthesize lastAuthenticationTimestamp = _lastAuthenticationTimestamp;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize httpRequestAuthenticationDispatcher = _requestAuthenticationDispatcher;
@synthesize delegate = _delegate;

- (id) init {
    self = [super init];
    if(self) {
        _timeoutInterval = 60 * 60;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_requestAuthenticationDispatcher release];
    [super dealloc];
}
#endif

- (void) updateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLUserLogin*) userLogin {
}    
       
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin 
                                     inContext:(id) context 
                                  withObserver:(id) observer {
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

- (FLUserLogin*) userLogin {
    FLAssertNotNil_(self.delegate); 
    return [self.delegate httpRequestAuthenticationServiceGetUserLogin:self];
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
authenticateSynchronouslyInContext:(id) context 
        withObserver:(id) observer {
    
    FLUserLogin* userLogin = self.userLogin;
    FLAssertNotNil_(userLogin); 
    
    if([self shouldAuthenticateUser:userLogin]) {
        [self resetAuthenticationTimestamp];

        userLogin = [self synchronouslyAuthenticateUser:userLogin inContext:context withObserver:observer];
        [self touchAuthenticationTimestamp];
        [self.delegate httpRequestAuthenticationService:self didAuthenticateUser:userLogin];
    }
    
    [self updateHttpRequest:httpRequest withAuthenticatedUser:userLogin];
}

- (BOOL) isAuthenticated {
    FLUserLogin* userLogin = self.userLogin;

    return userLogin && ![self shouldAuthenticateUser:userLogin];
}

- (void) logoutUser {
    [self resetAuthenticationTimestamp];
    [self.delegate httpRequestAuthenticationService:self didLogoutUser:self.userLogin];
}

- (void) touchAuthenticationTimestamp {
    _lastAuthenticationTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) resetAuthenticationTimestamp {
	_lastAuthenticationTimestamp = 0;
}

- (id<FLDispatcher>) httpRequestAuthenticationDispatcher:(FLHttpRequest*) httpRequest {

    if(!self.httpRequestAuthenticationDispatcher) {
        self.httpRequestAuthenticationDispatcher = [FLGcdDispatcher sharedFifoQueue];
    }

    return self.httpRequestAuthenticationDispatcher;
}

- (void) openService:(id) opener {
    [self resetAuthenticationTimestamp];
    FLPerformSelector(opener, @selector(httpRequestAuthenticatorServiceOpen:));
    [super openService:opener];
}

- (void) closeService:(id) closer {
    FLPerformSelector(closer, @selector(httpRequestAuthenticatorServiceClose:));
    [super closeService:closer];
    [self resetAuthenticationTimestamp];
}

@end