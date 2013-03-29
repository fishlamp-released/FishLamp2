//
//  FLObservable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLMessageSender.h"

@interface FLObservable : FLMessageSender {
@private
    __unsafe_unretained id _observer;
}

@property (readwrite, assign) id observer;

- (BOOL) sendObservation:(SEL) messageSelector;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer withObject:(id) object1 withObject:(id) object2;


@end

