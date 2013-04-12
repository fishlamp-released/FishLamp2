//
//  FLNetworkStream_Internal.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLNetworkStream ()

- (void) touchTimeoutTimestamp;

// required overrides
- (void) openStream;
- (void) closeStream;

// all of these are called on the async queue.
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


+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream;
- (void) queueBlock:(dispatch_block_t) block;
- (void) queueSelector:(SEL) selector;
- (void) queueSelector:(SEL) selector withObject:(id) object;

@end
