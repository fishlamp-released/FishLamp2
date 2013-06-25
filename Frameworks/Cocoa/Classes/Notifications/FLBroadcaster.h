//
//  FLBroadcaster.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

typedef enum {
    FLObserverNonretained       = (1 << 1),
    FLObserverMainThreadOnly    = (1 << 2)
} FLObserverBehavior;

@interface FLBroadcaster : NSObject {
@private 
    NSMutableArray* _listeners;
}

- (void) notify:(SEL) messageSelector;

- (void) notify:(SEL) messageSelector
        withObject:(id) object;

- (void) notify:(SEL) messageSelector
        withObject:(id) object1
        withObject:(id) object2;

- (void) notify:(SEL) messageSelector
        withObject:(id) object1
        withObject:(id) object2
        withObject:(id) object3;

- (void) notify:(SEL) messageSelector
        withObject:(id) object1
        withObject:(id) object2
        withObject:(id) object3
        withObject:(id) object4;

- (BOOL) hasObserver:(id) listener;

- (void) addObserverRetained:(id) observer;
- (void) addObserverNonretained:(id) observer;

- (void) removeObserver:(id) listener;

@end
