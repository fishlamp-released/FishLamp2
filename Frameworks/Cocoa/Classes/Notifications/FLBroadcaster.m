//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBroadcaster.h"
#import "FLDispatch.h"
#import "FLObjectMessage.h"

@implementation FLBroadcaster 

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

- (void) broadcast:(SEL) messageSelector {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [listener performOptionalSelector:messageSelector];
    }
}

- (void) broadcast:(SEL) messageSelector  
                     withObject:(id) object {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [listener performOptionalSelector:messageSelector withObject:object];
    }
}

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [listener performOptionalSelector:messageSelector withObject:object1 withObject:object2];
    }
}

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [listener performOptionalSelector:messageSelector withObject:object1 withObject:object2 withObject:object3];
    }
}

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3
                     withObject:(id) object4 {
    for(NSInteger i = _listeners.count - 1; i >= 0; i--) {
        id listener = [[_listeners objectAtIndex:i] nonretainedObjectValue];
        [listener performOptionalSelector:messageSelector withObject:object1 withObject:object2 withObject:object3 withObject:object4];
    }
}


@end