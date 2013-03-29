//
//  FLHttpRequestAuthenticationService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLHttpRequest.h"
#import "FLService.h"
#import "FLDispatchQueue.h"
#import "FLHttpUser.h"

@protocol FLHttpRequestAuthenticationServiceDelegate;


@interface FLHttpRequestAuthenticationService : FLService<FLHttpRequestAuthenticator> {
@private
    FLFifoAsyncQueue* _asyncQueue;
    __unsafe_unretained id<FLWorkerContext> _workerContext;
}
@property (readonly, assign) id<FLWorkerContext> workerContext;

// required overrides
- (void) authenticateUser:(FLHttpUser*) user;

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
    withAuthenticatedUser:(FLHttpUser*) user;

// optional override
- (BOOL) credentialsNeedAuthentication:(FLHttpUser*) user;

@end

@protocol FLHttpRequestAuthenticationServiceDelegate <NSObject>

- (id<FLWorkerContext>) httpRequestAuthenticationServiceGetWorkerContext:(FLHttpRequestAuthenticationService*) service;

- (FLHttpUser*) httpRequestAuthenticationServiceGetUser:(FLHttpRequestAuthenticationService*) service;

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
               didAuthenticateUser:(FLHttpUser*) user;

@optional 
- (void) httpRequestAuthenticationServiceDidOpen:(FLHttpRequestAuthenticationService*) service;
- (void) httpRequestAuthenticationServiceDidClose:(FLHttpRequestAuthenticationService*) service;

@end

