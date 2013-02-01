//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObserver.h"

@interface FLObserver ()
@end

@implementation FLObserver

#if FL_MRC
- (void) dealloc {
    for(int i = 0; i < FLObserverMaxListeners; i++) {
        [_listeners[i] release];
    }
    [super dealloc];
}
#endif

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
        
        for(int i = 0; i < _listenerCount; i++) {
            @try {  
                FLPerformSelectorWithArgCount(_listeners[i], selector, argCount, object1, object2, object3);
            }
            @catch(NSException* ex) {  
                FLAssertFailed_v(@"Not allowed to throw exceptions from object: %@", ex.reason);  
            } 
            
        }
    });
}              


- (void) postObservation:(SEL) selector  
              fromObject:(id) fromObject {
    [self postObservation:selector withObject:fromObject withObject:nil withObject:nil argCount:1];
}

- (void) postObservation:(SEL) selector 
              fromObject:(id) fromObject
              withObject:(id) object  {
    [self postObservation:selector withObject:fromObject withObject:object withObject:nil argCount:2];
}              

- (void) postObservation:(SEL) selector 
              fromObject:(id) fromObject
              withObject:(id) object1 
              withObject:(id) object2 {
    [self postObservation:selector withObject:fromObject withObject:object1 withObject:object2 argCount:3];
}   

- (void) addListener:(id) listener {
    dispatch_async(dispatch_get_main_queue(), ^{
        FLAssert_v(_listenerCount < FLObserverMaxListeners, @"too many listeners");
        if(_listenerCount < FLObserverMaxListeners) {
            FLSetObjectWithRetain(_listeners[_listenerCount++], listener);
        }
    });
}
              
@end
