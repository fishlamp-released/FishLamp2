//
//  FLNetworkConnectionObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"
#import "FLResult.h"

@class FLNetworkConnection;

@protocol FLNetworkConnectionObserver <NSObject> 
@optional

// added/removed from connection
- (void) observerWasAddedToNetworkConnection:(FLNetworkConnection*) connection;
- (void) observerWasRemovedFromNetworkConnection:(FLNetworkConnection*) connection;

// you only get one of each of these
- (void) networkConnectionStarting:(FLNetworkConnection*) connection;
- (void) networkConnection:(FLNetworkConnection*) connection finishedWithResult:(FLResult) result;

// connection events - can get multiples
- (void) networkConnectionConnecting:(FLNetworkConnection*) connection;
- (void) networkConnectionConnected:(FLNetworkConnection*) connection;
- (void) networkConnectionDisconnecting:(FLNetworkConnection*) connection;
- (void) networkConnectionDisconnected:(FLNetworkConnection*) connection;

//- (void) networkConnection:(FLNetworkConnection*) connection
//          encounteredError:(NSError*) error
//               ignoreError:(BOOL*) ignoreError; // ignore error is NO by default (which will terminate connection)

// only get this after 1 second, then once after activity starts again (idleDuration will be zero in this case)
- (void) networkConnection:(FLNetworkConnection*) connection
                 idleSince:(NSTimeInterval) lastActivityTimeStamp
              idleDuration:(NSTimeInterval) idleDuration;

// sending and receiving data
- (void) networkConnectionWillSendData:(FLNetworkConnection*) connection;
- (void) networkConnectionDidSendData:(FLNetworkConnection*) connection;
- (void) networkConnectionWillReadData:(FLNetworkConnection*) connection;
- (void) networkConnectionDidReadData:(FLNetworkConnection*) connection;

// special case probably only for http
- (void) networkConnection:(FLNetworkConnection*) connection
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url;
@end


