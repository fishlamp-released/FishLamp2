//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObserver.h"

@implementation NSObject (FLObserving)

- (void) postObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2
              withObject:(id) object3
              argCount:(NSInteger) argCount {

    dispatch_async(dispatch_get_main_queue(), ^{
        @try {  
            FLPerformSelectorWithArgCount(self, selector, argCount, object1, object2, object3);
        }
        @catch(NSException* ex) {  
            FLAssertFailed_v(@"Not allowed to throw exceptions from object: %@", ex.reason);  
        } 
    });
}              

- (void) postObservation:(SEL) selector  
              withObject:(id) object1 {
    [self postObservation:selector withObject:object1 withObject:nil withObject:nil argCount:1];
}

- (void) postObservation:(SEL) selector 
              withObject:(id) object1
              withObject:(id) object2  {
    [self postObservation:selector withObject:object1 withObject:object2 withObject:nil argCount:2];
}              

- (void) postObservation:(SEL) selector 
              withObject:(id) object1
              withObject:(id) object2 
              withObject:(id) object3 {
    [self postObservation:selector withObject:object1 withObject:object2 withObject:object3 argCount:3];
}   
              
@end
