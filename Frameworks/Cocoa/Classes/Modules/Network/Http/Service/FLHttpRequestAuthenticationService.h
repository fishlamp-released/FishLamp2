//
//  FLHttpRequestAuthenticationService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLHttpRequest.h"
#import "FLService.h"
#import "FLDispatchQueue.h"
#import "FLHttpUser.h"

@protocol FLHttpRequestAuthenticationServiceDelegate;

@interface FLHttpRequestAuthenticationService : FLService<FLHttpRequestAuthenticator> {
@private
    FLFifoAsyncQueue* _asyncQueue;
    
    __unsafe_unretained FLOperationContext* _operationContext;
    __unsafe_unretained id _delegate;
}
+ (id) httpRequestAuthenticationService;

@property (readwrite, assign, nonatomic) id<FLHttpRequestAuthenticationServiceDelegate> delegate;
@property (readonly, assign) FLOperationContext* operationContext;

- (FLPromise*) beginAuthenticating:(fl_completion_block_t) completion;

@end

@interface FLHttpRequestAuthenticationService (Overrides)
// required overrides
- (void) authenticateUser:(FLHttpUser*) user;

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLHttpUser*) user;

// optional override
- (BOOL) credentialsNeedAuthentication:(FLHttpUser*) user;
@end


@protocol FLHttpRequestAuthenticationServiceDelegate <NSObject>

- (FLOperationContext*) httpRequestAuthenticationServiceGetWorkerContext:(FLHttpRequestAuthenticationService*) service;

- (FLHttpUser*) httpRequestAuthenticationServiceGetUser:(FLHttpRequestAuthenticationService*) service;

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
               didAuthenticateUser:(FLHttpUser*) user;

@optional 
- (void) httpRequestAuthenticationServiceDidOpen:(FLHttpRequestAuthenticationService*) service;
- (void) httpRequestAuthenticationServiceDidClose:(FLHttpRequestAuthenticationService*) service;

@end

