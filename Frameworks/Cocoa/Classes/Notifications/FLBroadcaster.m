//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBroadcaster.h"
#import "FishLampAsync.h"

@implementation FLBroadcaster 

#if FL_MRC
- (void) dealloc {
    [_listeners release];
    [super dealloc];
}
#endif

- (BOOL) hasObserver:(id) listener {
    return [_listeners containsObject:listener];
}

- (void) addObserver:(id<FLObjectRef>) object {
    if(!_listeners) {
        _listeners = [[NSMutableArray alloc] init];
    }
    [_listeners addObject:object];
}

- (void) removeObserver:(id) listener {
    [_listeners removeObject:listener];
}

- (void) notify:(SEL) messageSelector {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        @try {
            [[_listeners objectAtIndex:i] performOptionalSelector:messageSelector];
        }
        @catch(NSException* ex) {
        }
    }
}

- (void) notify:(SEL) messageSelector  
                     withObject:(id) object {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        @try {
            [[_listeners objectAtIndex:i] performOptionalSelector:messageSelector
                                                   withObject:object];
        }
        @catch(NSException* ex) {
        }
    }
}

- (void) notify:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        @try {
            [[_listeners objectAtIndex:i] performOptionalSelector:messageSelector
                                                       withObject:object1
                                                       withObject:object2];
        }
        @catch(NSException* ex) {
        }
    }
}

- (void) notify:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        @try {
            [[_listeners objectAtIndex:i] performOptionalSelector:messageSelector
                                                       withObject:object1
                                                       withObject:object2
                                                       withObject:object3];
        }
        @catch(NSException* ex) {
        }
    }
}

- (void) notify:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3
                     withObject:(id) object4 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        @try {
            [[_listeners objectAtIndex:i] performOptionalSelector:messageSelector
                                                       withObject:object1
                                                       withObject:object2
                                                       withObject:object3
                                                       withObject:object4];
        }
        @catch(NSException* ex) {
        }
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

    BOOL listenerHandled = NO;
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [_listeners objectAtIndex:i];
        if([listener respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:listener];
            listenerHandled = YES;
        }
    }
    if(!listenerHandled) {
        [super forwardInvocation:anInvocation];
    }
}

- (BOOL) respondsToSelector:(SEL) selector {
    if([super respondsToSelector:selector]) {
        return YES;
    }
    for(id listener in _listeners) {
        if([listener respondsToSelector:selector]) {
            return YES;
        }
    }

    return NO;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for(id listener in _listeners) {
            signature = [listener methodSignatureForSelector:selector];
            if(signature) {
                break;
            }
        }
    }
    return signature;
}


@end