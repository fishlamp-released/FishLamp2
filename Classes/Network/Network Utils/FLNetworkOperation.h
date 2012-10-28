//
//  FLNetworkOperation.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLOperation.h"
#import "FLNetworkConnection.h"

@interface FLNetworkOperation : FLOperation<FLNetworkConnectionObserver> {
@private
    FLNetworkConnection* _networkConnection;
    
}
@property (readwrite, strong) FLNetworkConnection* networkConnection;

- (id) initWithNetworkConnection:(FLNetworkConnection*) connection;

+ (id) networkOperationWithConnection:(FLNetworkConnection*) connection;
+ (id) networkOperation;

// override points

- (FLNetworkConnection*) createNetworkConnection; 

// sets operationOutput by default.
- (void) handleAsyncResultFromConnection:(id) result;

@end


