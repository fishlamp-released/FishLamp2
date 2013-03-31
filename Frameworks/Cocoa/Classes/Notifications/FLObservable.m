//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

@implementation NSObject (FLObservationSending)

- (id) asyncObserver {
    return nil;
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) asyncObserver {
    return FLPerformSelectorOnMainThread1(asyncObserver, selector, self);
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) asyncObserver 
              withObject:(id) object  {
    return FLPerformSelectorOnMainThread2(asyncObserver, selector, self, object);
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) asyncObserver 
              withObject:(id) object1 
              withObject:(id) object2  {
    return FLPerformSelectorOnMainThread3(asyncObserver, selector, self, object1, object2);
}

- (BOOL) sendObservation:(SEL) selector {
    return FLPerformSelectorOnMainThread1(self.asyncObserver, selector, self);
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object  {
    return FLPerformSelectorOnMainThread2(self.asyncObserver, selector, self, object);
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2  {
    return FLPerformSelectorOnMainThread3(self.asyncObserver, selector, self, object1, object2);
}

@end

@implementation FLObservable 
@synthesize asyncObserver = _asyncObserver;
@end