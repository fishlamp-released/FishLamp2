//
//  FLHttpRequestAuthenticationService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpRequestAuthenticationService.h"
#import "FLHttpRequest.h"
#import "FLReachableNetwork.h"
#import "FishLampAsync.h"

#import "FLTrace.h"

@interface FLHttpRequestAuthenticationService ()
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueue; 
@property (readwrite, assign) FLOperationContext* operationContext;
@end

@implementation FLHttpRequestAuthenticationService

@synthesize asyncQueue = _asyncQueue;
@synthesize operationContext = _operationContext;
@synthesize delegate = _delegate;

+ (id) httpRequestAuthenticationService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
    
#if FL_MRC
    [_asyncQueue release];
    [super dealloc];
#endif
}

- (FLHttpUser*) user {
    return [self.delegate httpRequestAuthenticationServiceGetUser:self];
}

- (void) authenticateHttpRequest:(FLHttpRequest*) request 
           withAuthenticatedUser:(FLHttpUser*) user {
}    
       
- (void) authenticateUser:(FLHttpUser*) user {
}

- (BOOL) credentialsNeedAuthentication:(FLHttpUser*) user {

	FLAssertIsNotNil(user);
	
    if(!user.isLoginAuthenticated) {
        return YES;
    }

#if TEST_CACHE_EXPIRE
	userLogin.authTokenLastUpdateTimeValue = userLogin.authTokenLastUpdateTimeValue - (_timeoutInterval*2);
#endif
    
    if(user.authenticationHasExpired) {
    
        if([FLReachableNetwork instance].isReachable) {
            FLTrace(@"Login expired, will reauthenticate %@", user.userName);
            [user setLoginUnathenticated];
            return YES;
        }
    
        // don't want to reauthenticate if we're offline.
    }


	return NO;
}

- (void) openService {
    [super openService];
    self.asyncQueue = [FLFifoAsyncQueue fifoAsyncQueue];
    self.operationContext = [self.delegate httpRequestAuthenticationServiceGetWorkerContext:self];
}

- (void) closeService {
    [super closeService];
    
    self.operationContext = nil;
    FLFifoAsyncQueue* queue = FLRetainWithAutorelease(self.asyncQueue);
    self.asyncQueue = nil;
    [queue releaseToPool];
}

- (void) authenticateHttpRequest:(FLHttpRequest*) request {

    FLHttpUser* user = self.user;
    FLAssertNotNil(user); 
        
    [_asyncQueue runBlockSynchronously:^{
        
        if([self credentialsNeedAuthentication:user]) {
            
            [user resetAuthenticationTimestamp];

            [self authenticateUser:user];
                                               
            [user touchAuthenticationTimestamp];
            [self authenticateHttpRequest:request withAuthenticatedUser:user];
            [self.delegate httpRequestAuthenticationService:self didAuthenticateUser:user];
        }
        else {
            [self authenticateHttpRequest:request withAuthenticatedUser:user];
        }
    }];
    
    

//    return [[_asyncQueue queueBlock:^{
//        FLHttpUser* user = self.user;
//        FLAssertNotNil(user); 
//        
//        if([self shouldAuthenticateUser:user]) {
//            [self resetAuthenticationTimestamp];
//
//            user = [self authenticateUser:user];
//                                               
//            [self touchAuthenticationTimestamp];
//            FLPerformSelector2(self.delegate, @selector(httpRequestAuthenticationService:didAuthenticateUser:), self, user);
//        }
//        
//        [self authenticateHttpRequest:request withUser:user];
//    
//    }] waitUntilFinished];

}

- (void) queueBlock:(dispatch_block_t) block withCompletion:(fl_completion_block_t) completion {
    [_asyncQueue queueBlock:block withCompletion:completion];
}

- (void) beginAuthenticating:(fl_completion_block_t) completion {
    FLHttpUser* user = self.user;
    FLAssertNotNil(user); 

    [self queueBlock:^{
        FLTrace(@"started auth");
        [user resetAuthenticationTimestamp];
        [self authenticateUser:user];
        [user touchAuthenticationTimestamp];
        [self.delegate httpRequestAuthenticationService:self didAuthenticateUser:user];
    } 
    withCompletion:completion];

}

@end