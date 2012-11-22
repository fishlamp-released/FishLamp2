//
//	FLNetworkConnectionAuthenticator.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLNetworkConnectionAuthenticator.h"
#import "FLNetworkConnection.h"
#import "FLTraceOn.h"
#import "FLNetworkConnection_Internal.h"

@implementation FLNetworkConnectionAuthenticator

- (void) willAuthenticateConnection:(FLNetworkConnection*) connection {
}

- (BOOL) shouldAuthenticateConnection:(FLNetworkConnection*) connection {
    return NO;
}

- (NSError*) authenticateConnection:(FLNetworkConnection*) connection {
    return nil;
}

- (void) didAuthenticateConnection:(FLNetworkConnection*) connection {
}

- (void) beginAuthenticatingConnection:(FLNetworkConnection*) connection
                              callback:(void (^)(NSError* error)) callback {

//    [self willAuthenticateConnection:connection];
//
//    FLTrace(@"starting authentication for connection: %@", [connection description]);
//    
//    NSError* error = nil;
//
//    if(FLTestBits(connection.authenticationBehavior, FLHttpOperationSecuritySecureOperation)) {
//
//        if([self shouldAuthenticateConnection:connection]) {
//        
//            FLTrace(@"Will attempt to get lock for authentication: %@", NSStringFromClass([connection class]));
//
//            @synchronized(self)  {
//                
//                FLTrace(@"Got lock for authentication: %@", NSStringFromClass([connection class]));
//                
//                if([self shouldAuthenticateConnection:connection]) {
//
//                    FLTrace(@"Operation will authenticate for connection: %@", NSStringFromClass([connection class]));
//                    
//                    error = [self authenticateConnection:connection];
//                }
//                else {
//                    FLTrace(@"Authentication not needed for: %@", NSStringFromClass([connection class]));
//                }
//            }
//        }
//        else {
//            FLTrace(@"Authentication and lock not needed for: %@", NSStringFromClass([connection class]));
//        }
//    }
//
//    if(!error && FLTestBits(connection.authenticationBehavior, FLHttpOperationSecuritySecureConnection)) {
//        [self didAuthenticateConnection:connection];
//    }
//    
//    if(callback) {
//        callback(error);
//    }
}
        
@end