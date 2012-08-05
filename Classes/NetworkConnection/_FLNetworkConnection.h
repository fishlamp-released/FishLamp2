//
//  FLNetworkConnection_foo.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/9/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

// This api is for subclasses.

#import "FLNetworkConnection.h"

@interface FLNetworkConnection ()

// Not thread safe, only available in thread, e.g. during a notifier event.
@property (readwrite, assign, nonatomic) FLNetworkConnectionState connectionState;
@property (readwrite, assign, nonatomic) FLNetworkConnectionStateFlags connectionStateFlags;
@property (readwrite, assign, nonatomic) FLNetworkConnectionByteCount readByteCount;
@property (readwrite, assign, nonatomic) FLNetworkConnectionByteCount writeByteCount;
@property (readwrite, strong, nonatomic) NSError* error;
// override points
- (void) connectionDidFinish;

- (void) openNetworkStreams; // required override
- (void) connectionWillOpen;
- (void) connectionDidOpen;

- (void) closeNetworkStreams;   // required override
- (void) connectionWasClosed;

// optional override, but subclasses should call these as appropriate

- (void) connectionGotTimerEvent;
- (void) connectionIsIdle;

- (void) finishAuthenticatingWithSuccess:(BOOL) success;

/** this is called automatically, but you can call it yourself if you need to */
- (void) updateLastActivityTimestamp;

- (BOOL) waitOnceForRunLoop;

@end


