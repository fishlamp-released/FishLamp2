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

#if FL_MRC
- (void) dealloc {
    [_asyncQueue release];
    [super dealloc];
}
#endif

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
            FLTrace(@"Login expired, will reauthenticate %@", user.userLogin.userName);
            [user setLoginUnathenticated];
            return YES;
        }
    
        // don't want to reauthenticate if we're offline.
    }


	return NO;
}

- (void) openSelf {
    [super openSelf];
    self.asyncQueue = [FLFifoAsyncQueue fifoAsyncQueue];
    self.operationContext = [self.delegate httpRequestAuthenticationServiceGetOperationContext:self];
}

- (void) closeSelf {
    [super closeSelf];
    self.operationContext = nil;
    self.asyncQueue = nil;
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
}

- (FLPromise*) beginAuthenticating:(fl_completion_block_t) completion {
    FLHttpUser* user = self.user;
    FLAssertNotNil(user); 

    return [self.asyncQueue queueBlock:^{
        FLTrace(@"started auth");
        [user resetAuthenticationTimestamp];
        [self authenticateUser:user];
        [user touchAuthenticationTimestamp];
        [self.delegate httpRequestAuthenticationService:self didAuthenticateUser:user];
    } 
    completion:completion];
}

- (void) willStartProcessingObject:(id)object {
    if([object respondsToSelector:@selector(setHttpRequestAuthenticator:)]) {
        [object setHttpRequestAuthenticator:self];
    }
}

@end