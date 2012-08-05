//
//  FLNetworkConnectionObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLLinkedListElement.h"
#import "FLNetworkConnectionState.h"

@class FLNetworkConnection;

@protocol FLNetworkConnectionObserver <NSObject> 
@optional
- (void) networkConnectionWillStartObserving:(FLNetworkConnection*) connection;
- (void) networkConnectionWillOpen:(FLNetworkConnection*) connection;
- (void) networkConnectionDidOpen:(FLNetworkConnection*) connection;
- (void) networkConnectionWillAuthenticate:(FLNetworkConnection*) connection;
- (void) networkConnectionDidAuthenticate:(FLNetworkConnection*) connection;
- (void) networkConnectionDidClose:(FLNetworkConnection*) connection;
- (void) networkConnectionOnError:(FLNetworkConnection*) connection;
- (void) networkConnectionOnIdle:(FLNetworkConnection*) connection;
- (void) networkConnectionWillSendData:(FLNetworkConnection*) connection;
- (void) networkConnectionDidSendData:(FLNetworkConnection*) connection;
- (void) networkConnectionWillReadData:(FLNetworkConnection*) connection;
- (void) networkConnectionDidReadData:(FLNetworkConnection*) connection;
- (void) networkConnectionDidStopObserving:(FLNetworkConnection*) connection;
@end

typedef enum {
    FLNetworkEventWillStartObserving,
    FLNetworkEventWillOpen,
    FLNetworkEventDidOpen,
    FLNetworkEventWillAuthenticate,
    FLNetworkEventDidAuthenticate,
    FLNetworkEventDidClose,
    FLNetworkEventOnError,
    FLNetworkEventOnIdle,
    FLNetworkEventWillSendData,
    FLNetworkEventDidSendData,
    FLNetworkEventWillReadData,
    FLNetworkEventDidReadData,
    FLNetworkEventDidStopObserving,

    FLNetworkEventCount 
    
} FLNetworkEvent;

#import "FLCallback.h"

@interface FLNetworkConnectionObserver : FLLinkedListElement {
@private    
    FLCallback _observers[FLNetworkEventCount];
}
- (id) initWithTarget:(id) target; 

+ (FLNetworkConnectionObserver*) networkConnectionObserver:(id) target;

- (void) observeEvent:(FLNetworkEvent) event
               target:(id) target;

- (void) observeEvent:(FLNetworkEvent) event
               target:(id) target
               action:(SEL) action;

- (void) unobserveEvent:(FLNetworkEvent) event;

- (void) observeAllEventsWithTarget:(id) target;

- (void) unobserveAllEvents;

- (FLCallback) observerForEvent:(FLNetworkEvent) event;

+ (FLNetworkConnectionObserver*) networkConnectionObserver;

@end

#define FLNotifyObserver(__CONNECTION__, __OBSERVER__, __EVENT__) \
        FLCallbackInvoke([observer observerForEvent:__EVENT__], __CONNECTION__)




//    if([__OBSERVER__.target respondsToSelector:[__OBSERVER__ __SEL__]]) { \
//        [__OBSERVER__.target performSelector:[__OBSERVER__ __SEL__] withObject:__CONNECTION__]; \
//    }

/*
@class FLNetworkConnection;

typedef void (^SEL)(id connection);

//typedef void (^FLNetworkConnectionObserverWillReadDataBlock)(id connection, BOOL* didReadData);

typedef void (^FLNetworkConnectionObserverWillRedirectBlock)(id connection, BOOL* shouldRedirectToUrl, NSURL* url);

@interface FLNetworkConnectionObserver : FLLinkedListElement {
@private
    FLNetworkConnectionObserverBlock _onWillOpen;
    FLNetworkConnectionObserverBlock _onOpen;
    
    FLNetworkConnectionObserverBlock _onWillAuthenticate;
    FLNetworkConnectionObserverBlock _onDidAuthenticate;
    
    FLNetworkConnectionObserverBlock _onClose;
    
    FLNetworkConnectionObserverBlock _onStarted;
    FLNetworkConnectionObserverBlock _onStopped;
    
    FLNetworkConnectionObserverBlock _onError;
    FLNetworkConnectionObserverBlock _onIsIdle;

    FLNetworkConnectionObserverBlock _onWillSendData;
    FLNetworkConnectionObserverBlock _onDidSendData;

    FLNetworkConnectionObserverBlock _onWillReadData;
    FLNetworkConnectionObserverBlock _onDidReadData;

    FLNetworkConnectionObserverWillRedirectBlock _onWillRedirect;
}

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onStartedObserving; 
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onStoppedObserving; 

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onWillOpen;
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onOpen;

// If you fire this event, you are required to callback into the connection with [connection finishAuthenticatingWithSuccess:YES or NO]
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onWillAuthenticate;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onDidAuthenticate;

// not much choice when closing so no point on onWillClose
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onClose;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onError;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onWillSendData;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onDidSendData;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onWillReadData;
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onDidReadData;

/// @brief The onIdle handler is called when connection is idle.
/// This is called after 1 second of inactivity and then every 1 second of subsequent inactivity after that. 
/// It's then called once more if the connection gets activity.
@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverBlock onIdle;

@property (readwrite, copy, nonatomic) FLNetworkConnectionObserverWillRedirectBlock onWillRedirect;

+ (FLNetworkConnectionObserver*) networkConnectionObserver;

- (void) releaseBlocks;

@end

*/