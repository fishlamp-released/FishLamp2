//
//  FLHttpServerService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpServerService.h"

@implementation FLHttpServerService

synthesize_(authenticator);

- (void) openService {
    if(!self.authenticator) {
        self.authenticator = [self.parentService httpAuthenticator];
    }
    [super openService];
}

dealloc_(
    [_authenticator release];
)

- (void) httpOperationWillPrepare:(FLHttpOperation*) operation {
    operation.httpAuthenticator = self.authenticator;
}

//- (void) closeService {
//    self.authenticator = nil;
//    [super closeService];
//}

//- (void) httpOperation:(FLHttpOperation*) operation 
//     prepareConnection:(FLHttpConnection*) connection {
//
//    if(self.authenticator) {
//        [self.authenticator authenticateConnection:connection withAuthenticatedOperation:operation];
//    }
//}
//
//- (void) httpOperationWillRun:(FLHttpOperation*) operation {
//    if(operation.isSecure && operation.isAuthenticated) {
//        if(self.authenticator) {
//            [self.authenticator authenticateOperationSynchronously:operation];
//        }
//
//        operation.isAuthenticated = YES;
//    }
//}

@end
