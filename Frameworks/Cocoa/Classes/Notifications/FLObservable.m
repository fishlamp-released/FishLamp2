//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"
#import "FLSelectorPerforming.h"

@implementation NSObject (FLObservationSending)

- (BOOL) receiveObservation:(SEL) selector argCount:(int) argCount fromSender:(id) fromSender  withObject:(id) object1 withObject:(id) object2 {
    return FLPerformSelectorOnMainThreadWithArgCount(self, selector, argCount, fromSender, object1, object2);
}

- (BOOL) sendObservation:(SEL) selector toObserver:(id) observer argCount:(int) argCount withObject:(id) object1 withObject:(id) object2 {

    return [observer receiveObservation:selector argCount:argCount + 1 fromSender:self withObject:object1 withObject:object2];
}


- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer {
    return [self sendObservation:selector toObserver:observer argCount:0 withObject:nil withObject:nil];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object  {
    return [self sendObservation:selector toObserver:observer argCount:1 withObject:object withObject:nil];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  {
    return [self sendObservation:selector toObserver:observer argCount:2 withObject:object1 withObject:object2];
}

- (BOOL) sendObservation:(SEL) selector {
    return [self sendObservation:selector toObserver:self.asyncObserver argCount:0 withObject:nil withObject:nil];
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object  {
    return [self sendObservation:selector toObserver:self.asyncObserver argCount:1 withObject:object withObject:nil];
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2  {
    return [self sendObservation:selector toObserver:self.asyncObserver withObject:object1 withObject:object2];
}

- (BOOL) receiveObservation:(SEL) selector fromSender:(id) sender { 
    return FLPerformSelectorOnMainThreadWithArgCount(self, selector, 1, sender, nil, nil);
}

- (BOOL) receiveObservation:(SEL) selector fromSender:(id) sender withObject:(id) object  {
    return FLPerformSelectorOnMainThreadWithArgCount(self, selector, 2, sender, object, nil);
}

- (BOOL) receiveObservation:(SEL) selector fromSender:(id) sender withObject:(id) object1 withObject:(id) object2  {
    return FLPerformSelectorOnMainThreadWithArgCount(self, selector, 3, sender, object1, object2);
}


- (id) asyncObserver {
    return nil;
}

@end

@implementation FLObservable 

@synthesize asyncObserver = _asyncObserver;


@end