//
//  FLNetworkStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLCompatibility.h"
#import "NSObject+Copying.h"
#import "FLTimer.h"

@protocol FLNetworkStreamDelegate;
@class FLFifoAsyncQueue;

@interface FLNetworkStream : NSObject<FLTimerDelegate> {
@private
    BOOL _open;
    NSError* _error;
    FLFifoAsyncQueue* _asyncQueue;
    __unsafe_unretained id<FLNetworkStreamDelegate> _delegate;
    FLTimer* _timer;
}

@property (readwrite, assign) id<FLNetworkStreamDelegate> delegate;
@property (readonly, strong) FLFifoAsyncQueue* asyncQueue;

@property (readonly, assign, getter=isOpen) BOOL open;
@property (readonly, strong) NSError* error;

@property (readonly, strong) FLTimer* timer;

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue;
- (void) closeStream;
- (void) closeStreamWithError:(NSError*) error;

// all of these are called on the async queue.

// required overrides
- (void) willOpen;
- (void) willClose;
- (NSError*) streamError;

// optional overrides
- (void) didOpen;
- (void) didClose;

// stream events. All of these do nothing by default. They are called on the 
// async queue.
- (void) encounteredOpen;
- (void) encounteredCanAcceptBytes;
- (void) encounteredBytesAvailable;
- (void) encounteredError:(NSError*) error;
- (void) encounteredEnd;

- (void) touchTimeoutTimestamp;

@end

@interface FLNetworkStream (SubclassUtils)
+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream;
- (void) queueBlock:(dispatch_block_t) block;
- (void) queueSelector:(SEL) selector;
- (void) queueSelector:(SEL) selector withObject:(id) object;
@end

@protocol FLNetworkStreamDelegate <NSObject>

- (NSTimeInterval) networkStreamGetTimeoutInterval:(FLNetworkStream*) stream;

@optional

- (void) networkStreamWillOpen:(FLNetworkStream*) networkStream;

- (void) networkStreamDidOpen:(FLNetworkStream*) networkStream;

- (void) networkStreamWillClose:(FLNetworkStream*) stream;

- (void) networkStreamDidClose:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream encounteredError:(NSError*) error;

- (void) networkStreamHasBytesAvailable:(FLNetworkStream*) networkStream;

- (void) networkStreamCanAcceptBytes:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream didReadBytes:(NSNumber*) amountRead;

- (void) networkStream:(FLNetworkStream*) networkStream didWriteBytes:(NSNumber*) amountRead;

@end