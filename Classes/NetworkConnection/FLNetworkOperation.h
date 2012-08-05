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

@interface FLNetworkOperation : FLOperation {
@private
    FLNetworkConnection* _connection;
}

@property (readwrite, retain, nonatomic) FLNetworkConnection* networkConnection;

+ (id) networkOperation;    

// override points

- (FLNetworkConnection*) createNetworkConnection; 

- (void) willOpenConnection:(FLNetworkConnection*) connection;

- (void) didCloseConnection:(FLNetworkConnection*) connection;

@end


