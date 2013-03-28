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
@synthesize asyncQueue = _asyncQueue;
@synthesize delegate = _delegate;
@synthesize userLogin = _userLogin;


- (id) init {
    self = [super init];
    if(self) {
        _timeoutInterval = 60 * 60;
        _asyncQueue = [[FLFifoAsyncQueue alloc] init];
    }
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
    
#if FL_MRC
    [_userLogin release];
    
    [super dealloc];
#endif
}

- (void) updateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLUserLogin*) userLogin {
}    
       
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin 
                                     inContext:(id) context {
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

	FLAssertIsNotNil(userLogin);
	return ![self userLoginIsAuthenticated:userLogin];
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

- (void) openService {
    [self resetAuthenticationTimestamp];
    [super openService];
    
    [self.delegate httpRequestAuthenticationServiceDidOpen:self];
}

- (void) closeService {

    [super closeService];
    [self.delegate httpRequestAuthenticationServiceDidClose:self];

    [self resetAuthenticationTimestamp];
    self.userLogin = nil;
}

- (FLResult) authenticateHttpRequest:(FLHttpRequest*) request {

    return [[_asyncQueue queueBlock:^{
        FLUserLogin* userLogin = self.userLogin;
        FLAssertNotNil(userLogin); 
        
        if([self shouldAuthenticateUser:userLogin]) {
            [self resetAuthenticationTimestamp];

            userLogin = [self synchronouslyAuthenticateUser:userLogin 
                                                  inContext:request.workerContext  ];
                                               
            [self touchAuthenticationTimestamp];
            [self.delegate httpRequestAuthenticationService:self didAuthenticateUser:userLogin];
        }
        
        [self updateHttpRequest:request withAuthenticatedUser:userLogin];
    
    }] waitUntilFinished];

}

@end