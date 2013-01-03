//
//  FLAuthenticatedContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAuthenticatedContext.h"

@implementation FLAuthenticatedContext

@synthesize authenticationCredentials = _authenticationCredentials;

#if FL_MRC
- (void) dealloc {
    [_authenticationCredentials release];
    [super dealloc];
}
#endif

- (BOOL) isAuthenticated {
    return self.authenticationCredentials != nil;
}

- (void) willDispatchObject:(id) object {
    [super willDispatchObject:object];
    
    id<FLObjectAuthenticator> authenticator = FLReturnValueForOptionalProperty(object, @selector(authenticator));

    if(authenticator) {
        self.authenticationCredentials = [authenticator authenticateObject:object withCredentials:self.authenticationCredentials];
    }
}

@end


