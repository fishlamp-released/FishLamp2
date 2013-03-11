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

@protocol FLHttpRequestAuthenticationServiceDelegate;

@interface FLHttpRequestAuthenticationService : FLService<FLHttpRequestAuthenticator> {
@private
    NSTimeInterval _lastAuthenticationTimestamp;
    NSTimeInterval _timeoutInterval;
    id<FLDispatcher> _requestAuthenticationDispatcher;
    __unsafe_unretained id<FLHttpRequestAuthenticationServiceDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLHttpRequestAuthenticationServiceDelegate> delegate;
@property (readwrite, strong, nonatomic) id<FLDispatcher> httpRequestAuthenticationDispatcher; 

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

@property (readonly, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

@property (readonly, assign, nonatomic) NSTimeInterval lastAuthenticationTimestamp;
- (void) resetAuthenticationTimestamp;
- (void) touchAuthenticationTimestamp;

- (void) logoutUser;

// required overrides
- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin 
                                     inContext:(id) context
                                  withObserver:(id) observer;

- (void) updateHttpRequest:(FLHttpRequest*) request 
     withAuthenticatedUser:(FLUserLogin*) userLogin;

// optional
- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin;

@end

@protocol FLHttpRequestAuthenticationServiceDelegate <NSObject>

- (FLUserLogin*) httpRequestAuthenticationServiceGetUserLogin:(FLHttpRequestAuthenticationService*) service;

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(FLUserLogin*) userLogin;

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                            didLogoutUser:(FLUserLogin*) userLogin;
@end


@protocol FLHttpRequestAuthenticatorServiceOpener <NSObject>
@optional
- (void) httpRequestAuthenticatorServiceOpen:(id) service;
- (void) httpRequestAuthenticatorServiceClose:(id) service;
@end