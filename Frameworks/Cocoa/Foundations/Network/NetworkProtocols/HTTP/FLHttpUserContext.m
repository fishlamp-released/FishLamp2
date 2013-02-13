//
//  FLHttpUserContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserContext.h"


@implementation FLHttpUserContext 

@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize asyncDispatcher = _asyncDispatcher;
@synthesize serviceManager = _serviceManager;

- (id) init {
    self = [super init];
    if(self) {
        _asyncDispatcher = [[FLFifoGcdDispatcher alloc] init];
        _serviceManager = [[FLServiceManager alloc] init];
      }
    return self;
}

#if FL_MRC
- (void) dealloc {  
    [_serviceManager release];
    [_asyncDispatcher release];
    [_httpRequestAuthenticator release];
    [super dealloc];
}
#endif

- (FLUserLogin*) userLogin {
    return self.httpRequestAuthenticator.userLogin;
}

- (void) setUserLogin:(FLUserLogin*) userLogin {
    [self.httpRequestAuthenticator setUserLogin:userLogin];
}

- (BOOL) isContextAuthenticated {
    return self.httpRequestAuthenticator.isAuthenticated;
}

- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator:(FLHttpRequest*) request {
    return _httpRequestAuthenticator;
}

- (void) logoutUser {
}

@end