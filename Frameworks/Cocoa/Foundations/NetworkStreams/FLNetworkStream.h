//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"
#import "FLDispatcher.h"
#import "FLResult.h"
#import "FLResultProducing.h"
#import "FLCancellable.h"

@protocol FLNetworkStream <FLObservable, FLResultProducing, FLCancellable>

@property (readonly, assign) BOOL isOpen;

- (FLFinisher*) openStream:(id<FLDispatcher>) dispatcher 
         streamClosedBlock:(FLResultBlock) streamClosedBlock;

- (void) closeStreamWithResult:(id) result;
@end

@protocol FLNetworkStreamObserver <NSObject>
- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream;
@end

