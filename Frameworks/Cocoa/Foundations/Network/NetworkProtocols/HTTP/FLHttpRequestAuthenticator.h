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
    NSTimeInterval _authenticationTimeout;
    NSTimeInterval _timeoutInterval;
    
    __unsafe_unretained id _context;
}

@property (readonly, nonatomic, assign) id context;

- (id) initWithContext:(id) context authenticationTimeout:(NSTimeInterval) timeoutInterval;

@property (readonly, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

@property (readonly, assign, nonatomic) NSTimeInterval lastAuthenticationTimestamp;
- (void) resetAuthenticationTimestamp;

@property (readwrite, strong, nonatomic) FLUserLogin* userLogin;


// required overrides
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin;

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLUserLogin*) userLogin;

// optional
- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin;

@end