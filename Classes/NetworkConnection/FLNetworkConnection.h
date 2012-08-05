//
//  FLNetworkConnection.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/4/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

@protocol FLNetworkConnectionDelegate;

#import "FLNetworkConnectionObserver.h"
#import "FLLinkedList.h"
#import "FLNetworkConnectionObserver.h"

typedef enum {
    FLNetworkConnectionStateClosed,
    FLNetworkConnectionStateDisconnecting, // e.g. a stream exists, but isn't connected
    FLNetworkConnectionStateConnecting,
    FLNetworkConnectionStateAuthenticating,
    FLNetworkConnectionStateConnected,
} FLNetworkConnectionState;

enum { 
    FLNetworkConnectionStateFlagNone                    = 0,
    FLNetworkConnectionStateFlagAuthenticated           = (1 << 2),
    FLNetworkConnectionStateFlagAuthenticationFailed    = (1 << 3),
    FLNetworkConnectionStateFlagConnectionFailed        = (1 << 4),
    FLNetworkConnectionStateFlagFinished                = (1 << 5),

};

#define FLNetworkConnectionStateFlagFirstAvailableFlag    (1 << 10)

typedef uint32_t FLNetworkConnectionStateFlags;

typedef struct {
    unsigned long long lastChunkCount;
    unsigned long long totalCount;
    unsigned long long totalExpectedCount;
} FLNetworkConnectionByteCount;

extern const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero;

typedef void (^FLNetworkConnectionBlock)(id connection);

#define FLNetworkConnectionDefaultTimeout 120.0f

@interface FLNetworkConnection : NSObject {
@private
    NSError* _error;
    NSTimer* _timeoutTimer;
    FLLinkedList* _observers;
    FLNetworkConnectionStateFlags _connectionStateFlags;
    FLNetworkConnectionState _connectionState;
    NSTimeInterval _lastIdleEvent;
    NSTimeInterval _lastIdleTimeSpan;
    NSTimeInterval _timestamp;
    NSTimeInterval _timeoutInterval;
    NSUInteger _retryCount;
    FLNetworkConnectionByteCount _writeByteCount;
    FLNetworkConnectionByteCount _readByteCount;
    
    __weak NSThread* _thread; 
    __weak FLNetworkConnectionObserver* _currentObserver;
}

@property (readonly, assign, nonatomic) FLNetworkConnectionByteCount writeByteCount;

@property (readonly, assign, nonatomic) FLNetworkConnectionByteCount readByteCount;

/** usage */

// observers
- (void) addObserver:(FLNetworkConnectionObserver*) observer;

- (void) addObserversInArray:(NSArray*) listOfObservers;

- (void) removeObserver:(FLNetworkConnectionObserver*) observer;

// only set DURING a visitation, so that the observer can potentially
// remove itself (low use case scenario, but an important one)
@property (readonly, weak, nonatomic) FLNetworkConnectionObserver* currentObserver;

// this is not thread safe. Please use performBlockInConnectionThread if you're not on 
// the connection's thread.
- (void) visitObservers:(void (^)(FLNetworkConnectionObserver* observer, BOOL* stop)) visitor;

- (void) visitConnection:(FLNetworkConnectionBlock) callback; // queues up in the runloop of the connection.

// state
@property (readonly, assign, nonatomic) FLNetworkConnectionState connectionState;

@property (readonly, assign, nonatomic) FLNetworkConnectionStateFlags connectionStateFlags;

@property (readonly, strong, nonatomic) NSError* error;

@property (readonly, weak, fl_atomic) NSThread* thread;

- (void) openConnectionOnThread:(NSThread*) thread;

- (void) openConnectionOnCurrentThread; // open in current runloop/thread. You *MUST* call close connection (on any thread)
- (void) closeConnection; // can be called from any thread.

// do everything in a thread. Callback when done.
- (void) openConnectionAsync:(FLNetworkConnectionBlock) finishedBlock; // finished block is called from the thread the connection ran in.

- (void) blockUntilFinished;

/** timeouts */
@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

@property (readonly, assign, nonatomic) NSTimeInterval lastActivityTimestamp;

@property (readonly, assign, nonatomic) NSTimeInterval idleTimespan; // time since any activity.

/** retry support */
@property (readonly, assign, nonatomic) NSUInteger retryCount;

- (BOOL) retryConnectionIfPossible; // return YES if it will try.



@end


