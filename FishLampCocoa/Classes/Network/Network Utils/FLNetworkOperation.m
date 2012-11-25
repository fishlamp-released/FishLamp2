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
#import "FLDispatchQueue.h"

@interface FLNetworkOperation ()
@property (readwrite, strong) FLNetworkConnection* connection;
@end

@implementation FLNetworkOperation

@synthesize connection = _networkConnection;

- (void) setNetworkConnection:(FLNetworkConnection*) connection {
    if(connection) {
        [self.connection removeObserver:self];
    }
    self.connection = connection;
    [self.connection addObserver:self];
}

- (FLNetworkConnection*) networkConnection {
    return self.connection;
}

- (id) init {
    self = [super init];
    if(self) {
	}
    
    return self;
}

+ (id) networkOperation {
	return autorelease_([[[self class] alloc] init]);
}

- (id) initWithNetworkConnection:(FLNetworkConnection*) connection {
    self = [super init];
    if(self) {
        self.networkConnection = connection;
    }
    return self;
}

+ (id) networkOperationWithConnection:(FLNetworkConnection*) connection {
    return autorelease_([[[self class] alloc] initWithNetworkConnection:connection]);
}


- (void) cancelSelf {
	[super cancelSelf];
    if(_networkConnection) {
        [_networkConnection requestCancel];
    }
}

- (void) dealloc {
    [_networkConnection removeObserver:self];

#if FL_MRC
    release_(_networkConnection);
	super_dealloc_();
#endif
}

- (FLNetworkConnection*) createNetworkConnection {
    return nil;
}

- (void) prepareSelf {
    [super prepareSelf];
	if(!self.networkConnection) {
		self.networkConnection = [self createNetworkConnection];
	}
    FLConfirmNotNil_v(self.networkConnection, @"the connection is nil");
}

- (void) handleAsyncResultFromConnection:(id) output {
    self.operationOutput = output;
}

- (void) runSelf {

    FLAssertIsNotNil_v(self.networkConnection, nil);
    
    FLFinisher* finisher = [self.networkConnection openConnection:FLFifoQueue];
    [finisher waitUntilFinished];
    id result = finisher.result;

    if([result error]) {
        self.error = result;
    }
    else {
        [self handleAsyncResultFromConnection:result];
    }
}

@end
