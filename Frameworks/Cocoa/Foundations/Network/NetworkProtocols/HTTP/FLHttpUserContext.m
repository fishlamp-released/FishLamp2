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

- (id) init {
    self = [super init];
    if(self) {
        _httpRequestQueue = [[FLFifoDispatchQueue alloc] init];
        _objects = [[FLDispatchedObjectCollection alloc] init];
      }
    return self;
}

#if FL_MRC
- (void) dealloc {  
    [_objects release];
    [_httpRequestQueue release];
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

- (void) requestCancel {
    [_objects requestCancel];
}

- (id<FLDispatching>) httpRequestFifoDispatcher:(FLHttpRequest*) request {
    return _httpRequestQueue;
}

- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator:(FLHttpRequest*) request {
    return _httpRequestAuthenticator;
}

- (id<FLDispatching>) operationDispatcher:(FLOperation*) operation {
    return FLDefaultDispatcher;
}

- (void) operationDidStart:(FLOperation*) operation {
    [_objects addObject:operation];
}

- (void) operationDidFinish:(FLOperation*) operation {
    [_objects removeObject:operation];
}

- (void) httpRequestDidStart:(FLHttpRequest*) request {
    [_objects addObject:request];
}

- (void) httpRequestDidFinish:(FLHttpRequest*) request {
    [_objects removeObject:request];
}

- (void) logoutUser {
}

@end