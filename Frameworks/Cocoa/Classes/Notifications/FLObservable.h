//
//  FLObservable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "FishLampCore.h"

@interface NSObject (FLObservationReceiving)
- (BOOL) receiveObservation:(SEL) messageSelector;

- (BOOL) receiveObservation:(SEL) messageSelector withObject:(id) object;

- (BOOL) receiveObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2;

- (BOOL) receiveObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;

@end

@interface NSObject (FLObservationSending)

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) asyncObserver;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) asyncObserver withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) asyncObserver withObject:(id) object1 withObject:(id) object2;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) asyncObserver withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;

- (id) asyncObserver;

// these use [self asyncObserver] as toObserver parameter

- (BOOL) sendObservation:(SEL) messageSelector;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;

@end

@interface FLObservable : NSObject {
@private
    __unsafe_unretained id _asyncObserver;
}
@property (readwrite, assign) id asyncObserver;
@end



