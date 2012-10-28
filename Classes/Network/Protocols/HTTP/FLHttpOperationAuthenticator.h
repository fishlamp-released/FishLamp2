//
//	FLHttpOperationAuthenticator.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@class FLHttpOperation;
@class FLHttpConnection;

@protocol FLHttpOperationAuthenticator <NSObject>

- (void) setDefaultSecurityForOperation:(FLHttpOperation*) operation;

// actually do the authentication, or load from cache or whatever.
- (void) authenticateOperationSynchronously:(FLHttpOperation*) operation;

// set headers or whatever.
- (void) authenticateConnection:(FLHttpConnection*) connection
     withAuthenticatedOperation:(FLHttpOperation*) operation;

@end

