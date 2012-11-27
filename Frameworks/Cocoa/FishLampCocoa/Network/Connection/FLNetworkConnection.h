//
//  FLNetworkConnection.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/4/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLNetworkConnectionObserver.h"
#import "FLBitFlags.h"
#import "FLObservable.h"
#import "FLFinisher.h"
#import "FLTimeoutTimer.h"
#import "FLNetworkStream.h"
#import "FLDispatcher.h"
#import "FLDispatchQueue.h"
#import "FLCancellable.h"

#define FLNetworkConnectionDefaultTimeout 120.0f

typedef struct {
    unsigned long lastChunkCount;
    unsigned long totalCount;
    unsigned long totalExpectedCount;
} FLNetworkConnectionByteCount;

extern const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero;

@interface FLNetworkConnection : FLObservable<FLNetworkStreamObserver, FLCancellable> {
@private
    id<FLNetworkStream> _networkStream;
    FLTimeoutTimer* _timeoutTimer;
    FLNetworkConnectionByteCount _writeByteCount;
    FLNetworkConnectionByteCount _readByteCount;
    FLFinisher* _cancelFinisher;
}

@property (readonly, strong) FLTimeoutTimer* timeoutTimer;
@property (readonly, assign) FLNetworkConnectionByteCount writeByteCount;
@property (readonly, assign) FLNetworkConnectionByteCount readByteCount;
@property (readonly, strong) id<FLNetworkStream> networkStream;

- (void) touchTimestamp;

- (FLFinisher*) openConnection:(FLDispatchQueue*) dispatcher;

// override point.
- (id) resultFromStream:(id<FLNetworkStream>) stream;
- (id<FLNetworkStream>) createNetworkStream;

/** retry support */
//    NSUInteger _retryCount;
//@property (readonly, assign) NSUInteger retryCount;
//
//- (BOOL) retryConnectionIfPossible; // return YES if it will try.
@end

//
//@interface FLNetworkConnection (HACK)
//+ (NSError *) errorFromStreamError:(CFStreamError) streamError;
//@end
//
