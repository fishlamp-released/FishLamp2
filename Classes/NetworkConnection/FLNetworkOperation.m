//
//  FLNetworkOperation.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkOperation.h"
#import "FLReachableNetwork.h"
#import "FLNetworkConnectionObserver.h"

@interface FLNetworkOperation ()
- (void) createNetworkRequestIfNeeded;
@end

@implementation FLNetworkOperation

@synthesize networkConnection = _networkConnection;

- (id) init {
    self = [super init];
    if(self) {
	}
    
    return self;
}

+ (id) networkOperation {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) requestCancel {
	[super requestCancel];
    if(_connection) {
        [_connection closeConnection];
    }
}

- (BOOL) wasCancelled {
	return [super wasCancelled];
}

#if FL_DEALLOC 
- (void) dealloc {
 	FLRelease(_connection);
	FLSuperDealloc();
}
#endif

- (FLNetworkConnection*) createNetworkConnection {
    return nil;
}

- (void) createNetworkRequestIfNeeded {
	if(!self.networkConnection) {
		self.networkConnection = [self createNetworkConnection];
	}
}

- (void) operationSetup { 
	[super operationSetup];
    [self createNetworkRequestIfNeeded];
}

- (void) willOpenConnection:(FLNetworkConnection*) connection
{
}

- (void) didCloseConnection:(FLNetworkConnection*) connection
{
}

- (void) networkConnectionDidClose:(FLNetworkConnection*) connection {
    if(connection.error) {
        self.error = connection.error;
    }
    else {
        @try {
            [self didCloseConnection:connection];
        }
        @catch(NSException* ex) {
            self.error = ex.error;
        }
    }
}

- (void) networkConnectionOnError:(FLNetworkConnection*) connection {
    self.error = connection.error;
}

- (void) performSelf {

	if(!self.error && !self.wasCancelled) {	
    
        [self createNetworkRequestIfNeeded];
    
       	FLAssertIsNotNil(self.networkConnection);
	    
        [self.networkConnection addObserver:[FLNetworkConnectionObserver networkConnectionObserver:self]];
        @try {
            [self willOpenConnection:self.networkConnection];
            [self.networkConnection openConnectionOnCurrentThread];
            [self.networkConnection blockUntilFinished];	   
        }
        @catch(NSException* ex){
            self.error = ex.error;
        }
    }
}

@end
