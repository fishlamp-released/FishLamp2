//
//  FLHttpUserService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserService.h"
#import "FLGlobalNetworkActivityIndicator.h"

@implementation FLHttpUserService 

@synthesize asyncDispatcher = _asyncDispatcher;

FLSynthesizeServiceProperty(httpRequestAuthenticator, setHttpRequestAuthenticator, FLHttpRequestAuthenticationService*, _httpRequestAuthenticator);

- (id) init {
    self = [super init];
    if(self) {
        _asyncDispatcher = [[FLFifoGcdDispatcher alloc] init];
    }
    return self;
}

+ (id) httpUserService {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {  
    [_asyncDispatcher release];
    [_httpRequestAuthenticator release];
    [super dealloc];
}
#endif

//- (FLUserLogin*) userLogin {
//    return self.httpRequestAuthenticator.userLogin;
//}
//
//- (void) setUserLogin:(FLUserLogin*) userLogin {
//    [self.httpRequestAuthenticator setUserLogin:userLogin];
//}

- (BOOL) isContextAuthenticated {
    return self.httpRequestAuthenticator.isAuthenticated;
}

- (void) logoutUser {
    [self.httpRequestAuthenticator logoutUser];
}

- (void) didStartWorking {
    [super didStartWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = YES;
}

- (void) didStopWorking {
    [super didStopWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = NO;
}

@end