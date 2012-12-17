//
//	FLNetworkConnectionAuthenticator.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

@class FLNetworkConnection;

@protocol FLNetworkConnectionAuthenticator <NSObject>

- (void) beginAuthenticatingConnection:(FLNetworkConnection*) connection
    callback:(void (^)(NSError* error)) callback;

@end

@interface FLNetworkConnectionAuthenticator : NSObject<FLNetworkConnectionAuthenticator> {
}

- (void) willAuthenticateConnection:(FLNetworkConnection*) connection;
- (BOOL) shouldAuthenticateConnection:(FLNetworkConnection*) connection;
- (NSError*) authenticateConnection:(FLNetworkConnection*) connection;
- (void) didAuthenticateConnection:(FLNetworkConnection*) connection;

@end
