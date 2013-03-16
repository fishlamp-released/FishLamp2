//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLMessageBroadcaster.h"
#import "FLDispatch.h"
#import "FLObjectMessage.h"

@implementation FLMessageBroadcaster 

#if FL_MRC
- (void) dealloc {
    [_listeners release];
    [super dealloc];
}
#endif

- (void) addListener:(id) listener {
    if(!_listeners) {
        _listeners = [[NSMutableArray alloc] init];
    }
    
    [_listeners addObject:[NSValue valueWithNonretainedObject:listener]];
}

- (void) removeListener:(id) listener {
    [_listeners removeObject:[NSValue valueWithNonretainedObject:listener]];
}

- (void) sendObjectMessageToListeners:(FLObjectMessage *)message {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [self sendObjectMessage:message toListener:listener];
    }
}

- (void) sendMessageToListeners:(SEL) messageSelector {
    [self sendObjectMessageToListeners:[FLObjectMessage objectMessage:messageSelector withObject:self]];
}

- (void) sendMessageToListeners:(SEL) messageSelector  
                     withObject:(id) object {
    [self sendObjectMessageToListeners:[FLObjectMessage objectMessage:messageSelector withObject:self withObject:object]];
}

- (void) sendMessageToListeners:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2 {
    [self sendObjectMessageToListeners:[FLObjectMessage objectMessage:messageSelector withObject:self withObject:object1 withObject:object2]];
}


@end