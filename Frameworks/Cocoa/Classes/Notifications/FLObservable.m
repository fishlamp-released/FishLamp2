//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLObservable.h"
#import "FLSelectorPerforming.h"

@implementation NSObject (FLObservationSending)

- (BOOL) receiveObservation:(SEL) selector { 
    return FLPerformSelectorOnMainThread0(self, selector);
}

- (BOOL) receiveObservation:(SEL) selector 
                 withObject:(id) object  {
    return FLPerformSelectorOnMainThread1(self, selector, object);
}

- (BOOL) receiveObservation:(SEL) selector 
                 withObject:(id) object1 
                 withObject:(id) object2  {
    return FLPerformSelectorOnMainThread2(self, selector, object1, object2);
}

- (BOOL) receiveObservation:(SEL) selector  
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3 {
    return FLPerformSelectorOnMainThread3(self, selector, object1, object2, object3);
}

- (BOOL) receiveObservation:(SEL) selector  
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3
                 withObject:(id) object4 {
    return FLPerformSelectorOnMainThread4(self, selector, object1, object2, object3, object4);
}

- (BOOL) sendObservation:(SEL) selector
              toObserver:(id) observer {
    return [observer receiveObservation:selector];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object  {
    return [observer receiveObservation:selector withObject:object];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  {
    return [observer receiveObservation:selector withObject:object1 withObject:object2];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3  {
    return [observer receiveObservation:selector withObject:object1 withObject:object2 withObject:object3];
}

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3
              withObject:(id) object4  {
    return [observer receiveObservation:selector withObject:object1 withObject:object2 withObject:object3 withObject:object4];
}

@end

@implementation FLObservable 

@synthesize observer = _observer;

- (BOOL) sendObservation:(SEL) selector {
    return [self sendObservation:selector toObserver:self.observer];
}

- (BOOL) sendObservation:(SEL) selector 
              withObject:(id) object  {
    return [self sendObservation:selector toObserver:self.observer withObject:object];
}

- (BOOL) sendObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2{
    return [self sendObservation:selector toObserver:self.observer withObject:object1 withObject:object2];
}

- (BOOL) sendObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2 
              withObject:(id) object3 {
    return [self sendObservation:selector toObserver:self.observer withObject:object1 withObject:object2 withObject:object3];
}

@end