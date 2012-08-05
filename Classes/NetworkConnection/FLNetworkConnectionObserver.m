//
//  FLNetworkConnectionObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkConnectionObserver.h"

@implementation FLNetworkConnectionObserver 


static SEL* s_defaultActions = nil;

+ (void) initialize {
    
    if(!s_defaultActions) {
        s_defaultActions = malloc(sizeof(SEL) * FLNetworkEventCount);
         
        s_defaultActions[FLNetworkEventWillStartObserving] = 
                   @selector(networkConnectionWillStartObserving:);

        s_defaultActions[FLNetworkEventWillOpen] =
             @selector(networkConnectionWillOpen:);
             
        s_defaultActions[FLNetworkEventDidOpen] =
             @selector(networkConnectionDidOpen:);

        s_defaultActions[FLNetworkEventWillAuthenticate] =
             @selector(networkConnectionWillAuthenticate:);

        s_defaultActions[FLNetworkEventDidAuthenticate] =
             @selector(networkConnectionDidAuthenticate:);

        s_defaultActions[FLNetworkEventDidClose] =
             @selector(networkConnectionDidClose:);

        s_defaultActions[FLNetworkEventOnError] =
             @selector(networkConnectionOnError:);

        s_defaultActions[FLNetworkEventOnIdle] =
             @selector(networkConnectionOnIdle:);

        s_defaultActions[FLNetworkEventWillSendData] =
             @selector(networkConnectionWillSendData:);

        s_defaultActions[FLNetworkEventDidSendData] =
             @selector(networkConnectionDidSendData:);

        s_defaultActions[FLNetworkEventWillReadData] =
             @selector(networkConnectionWillReadData:);

        s_defaultActions[FLNetworkEventDidReadData] =
             @selector(networkConnectionDidReadData:);

        s_defaultActions[FLNetworkEventDidStopObserving] =
             @selector(networkConnectionDidStopObserving:);
    }
}

- (id) initWithTarget:(id) target {
    self = [self init]; 
    if(self) {
    }
    
    return self;
}

+ (FLNetworkConnectionObserver*) networkConnectionObserver {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}


+ (FLNetworkConnectionObserver*) networkConnectionObserver:(id) target {
    return FLReturnAutoreleased([[[self class] alloc] initWithTarget:target]);
}


- (id) init {
    self = [super init]; 
    if(self) {
    }
    return self;
}

- (void) observeAllEventsWithTarget:(id) target {
        
    if(target) {
        for(int i = 0; i < FLNetworkEventCount; i++) {
            _observers[i] = FLCallbackMake(target, s_defaultActions[i]);
        }
    }
}


- (void) unobserveAllEvents {
    memset(_observers, 0, sizeof(_observers)); // clear out the delegates in case we're reused.
}

- (void) dealloc {
    FLSuperDealloc();
}

- (void) observeEvent:(FLNetworkEvent) event
               target:(id) target {
    
    if(event < FLNetworkEventCount) {
        [self observeEvent:event target:target action:s_defaultActions[event]];
    }
}

- (void) observeEvent:(FLNetworkEvent) event
               target:(id) target
               action:(SEL) action {

    if(event < FLNetworkEventCount) {
        
        FLAssert([target respondsToSelector:action], @"target (%@) doesn't respond to action %@", NSStringFromClass([target class]), NSStringFromSelector(action));

        _observers[event] = FLCallbackMake(target, action);
    }
}

- (FLCallback) observerForEvent:(FLNetworkEvent) event {
    if(event < FLNetworkEventCount) {
        return _observers[event];
    }
    
    return FLCallbackZero;
}

- (void) unobserveEvent:(FLNetworkEvent) event {
    if(event < FLNetworkEventCount) {
        _observers[event] = FLCallbackZero;
    }
}

@end
