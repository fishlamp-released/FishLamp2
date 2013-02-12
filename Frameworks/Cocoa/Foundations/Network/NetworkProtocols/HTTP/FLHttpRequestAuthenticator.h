//
//  FLHttpRequestAuthenticator.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLUserLogin.h"
#import "FLHttpRequest.h"

@interface FLHttpRequestAuthenticator : NSObject<FLHttpRequestAuthenticator> {
@private
    FLUserLogin* _userLogin;
    NSTimeInterval _lastAuthenticationTimestamp;
    NSTimeInterval _timeoutInterval;
}

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

@property (readonly, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

@property (readonly, assign, nonatomic) NSTimeInterval lastAuthenticationTimestamp;
- (void) resetAuthenticationTimestamp;
- (void) touchAuthenticationTimestamp;

@property (readwrite, strong, nonatomic) FLUserLogin* userLogin;

// called by the request when it needs to authenticate
- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest;

// required overrides
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin;

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLUserLogin*) userLogin;

// optional
- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin;

@end