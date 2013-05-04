//
//  FLBroadcaster.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLBroadcaster : NSObject {
@private 
    NSMutableArray* _listeners;
}

- (void) broadcast:(SEL) messageSelector;

- (void) broadcast:(SEL) messageSelector  
                     withObject:(id) object;

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2;

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3;

- (void) broadcast:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2
                     withObject:(id) object3
                     withObject:(id) object4;

- (void) addListener:(id) listener;

- (void) removeListener:(id) listener;


@end
