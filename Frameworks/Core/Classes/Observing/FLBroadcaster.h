//
//  FLBroadcaster.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"
#import "FLArrayProxy.h"

// these are here as a convenience
#import "FLObjectProxy.h"
#import "FLRetainedObject.h"
#import "FLNonretained.h"
#import "FLMainThreadObject.h"

@interface FLBroadcaster : FLAbstractArrayProxy<NSFastEnumeration> {
@private
    NSMutableArray* _listeners;
}

- (id) all;

- (void) performSelector:(SEL) messageSelector;

- (void) performSelector:(SEL) messageSelector
              withObject:(id) object;

- (void) performSelector:(SEL) messageSelector
              withObject:(id) object1
              withObject:(id) object2;

- (void) performSelector:(SEL) messageSelector
              withObject:(id) object1
              withObject:(id) object2
              withObject:(id) object3;

- (void) performSelector:(SEL) messageSelector
              withObject:(id) object1
              withObject:(id) object2
              withObject:(id) object3
              withObject:(id) object4;

- (BOOL) hasListener:(id) listener;

- (void) addListener:(id) observer;

- (void) removeListener:(id) listener;

@end
