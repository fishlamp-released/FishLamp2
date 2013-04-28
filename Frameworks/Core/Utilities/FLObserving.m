//
//  FLObserving.m
//  FishLampCore
//
//  Created by Mike Fullerton on 4/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObserving.h"
#import "FLSelectorPerforming.h"

@implementation NSObject (FLObserving)

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

@end
