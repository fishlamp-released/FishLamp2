//
//  FLNetworkOperation.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLOperation.h"
#import "FLNetworkConnection.h"
#import "FLResult.h"

@interface FLNetworkOperation : FLOperation<FLNetworkConnectionObserver> {
@private
    // needd for cancelling
    FLNetworkConnection* _connection;
}

+ (id) networkOperation;

- (FLResult) runConnection:(FLNetworkConnection*) connection;

@end


/*
    NSURL* _URL;
@property (readwrite, strong) NSURL* URL;

- (id) initWithURL:(NSURL*) url;
+ (id) networkOperation:(NSURL*) url;
*/