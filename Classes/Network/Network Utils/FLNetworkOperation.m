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
- (void) createNetworkConnectionIfNeeded;
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
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (id) initWithNetworkConnection:(FLNetworkConnection*) connection {
    self = [super init];
    if(self) {
        self.networkConnection = connection;
    }
    return self;
}

+ (id) networkOperationWithConnection:(FLNetworkConnection*) connection {
    return FLReturnAutoreleased([[[self class] alloc] initWithNetworkConnection:connection]);
}


- (void) cancelSelf {
	[super cancelSelf];
    if(_networkConnection) {
        [_networkConnection cancelConnection];
    }
}

- (void) dealloc {
    [_networkConnection removeObserver:self];

#if FL_NO_ARC
    FLRelease(_networkConnection);
	FLSuperDealloc();
#endif
}

- (FLNetworkConnection*) createNetworkConnection {
    return nil;
}

- (void) createNetworkConnectionIfNeeded {
	if(!self.networkConnection) {
		self.networkConnection = [self createNetworkConnection];
	}
}

- (void) prepareSelf {
    [super prepareSelf];
    [self createNetworkConnectionIfNeeded];
}

- (void) handleAsyncResultFromConnection:(id) output {
    self.operationOutput = output;
}

- (void) runSelf {

    FLAssertIsNotNil_v(self.networkConnection, nil);
    
    FLFinisher* finisher = [self.networkConnection openConnection:^(id<FLAsyncResult> result){
        if(result.error) {
            self.error = result.error;
        }
        else {
            [self handleAsyncResultFromConnection:result.asyncResult];
        }
    }];
    [finisher waitUntilFinished];
}

@end
