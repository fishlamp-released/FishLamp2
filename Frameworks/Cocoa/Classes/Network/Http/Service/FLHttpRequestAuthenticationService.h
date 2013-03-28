//
//  FLHttpRequestAuthenticationService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLUserLogin.h"
#import "FLHttpRequest.h"
#import "FLService.h"
#import "FLDispatchQueue.h"

@protocol FLHttpRequestAuthenticationServiceDelegate;

@interface FLHttpRequestAuthenticationService : FLService<FLHttpRequestAuthenticator> {
@private
    NSTimeInterval _lastAuthenticationTimestamp;
    NSTimeInterval _timeoutInterval;
    FLFifoAsyncQueue* _asyncQueue;
    FLUserLogin* _userLogin;
    
    __unsafe_unretained id<FLHttpRequestAuthenticationServiceDelegate> _delegate;
}
@property (readwrite, strong) FLUserLogin* userLogin;

@property (readwrite, assign, nonatomic) id<FLHttpRequestAuthenticationServiceDelegate> delegate;
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueue; 

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

@property (readonly, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

@property (readonly, assign, nonatomic) NSTimeInterval lastAuthenticationTimestamp;
- (void) resetAuthenticationTimestamp;
- (void) touchAuthenticationTimestamp;

- (void) logoutUser;

// required overrides
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin 
                                     inContext:(id) context;

- (void) updateHttpRequest:(FLHttpRequest*) request 
     withAuthenticatedUser:(FLUserLogin*) userLogin;

// optional
- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin;

@end

@protocol FLHttpRequestAuthenticationServiceDelegate <NSObject>

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(FLUserLogin*) userLogin;

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                            didLogoutUser:(FLUserLogin*) userLogin;

- (void) httpRequestAuthenticationServiceDidOpen:(FLHttpRequestAuthenticationService*) service;
- (void) httpRequestAuthenticationServiceDidClose:(FLHttpRequestAuthenticationService*) service;

@end

