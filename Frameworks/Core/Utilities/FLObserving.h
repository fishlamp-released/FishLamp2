//
//  FLObserving.h
//  FishLampCore
//
//  Created by Mike Fullerton on 4/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FLObserving)

// observations are queued on the main thread,
// these are used for notifying UI code from async threads.
// if the target doesn't respond to the selector, NO is returned
// and the message is ignored

- (BOOL) receiveObservation:(SEL) messageSelector;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3
                 withObject:(id) object4;
                 
@end                 