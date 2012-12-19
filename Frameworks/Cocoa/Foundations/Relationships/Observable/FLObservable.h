//
//  FLObservable2.h
//  FLCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

typedef void (^FLObservableBlock)(id observedObject, id object1, id object2);

@protocol FLObservable <NSObject>

/// gets all event selectors (if the observer implements them)
- (void) addObserver:(id) observer; 

- (void) addObserver:(id) observer forEvent:(SEL) event;

/// observe a specific event and use a different selector to respond to it.
- (void) addObserver:(id) observer forEvent:(SEL) event withSelector:(SEL) selector ; 

/// observe a specific event and use a block to respond to it.
- (void) addObserver:(id) observer forEvent:(SEL) event withBlock:(FLObservableBlock) block; 

- (void) removeObserver:(id) observer forEvent:(SEL) event;

/// this is slow.
- (void) removeObserver:(id) observer;

//
// for subclasses
//

- (void) postObservation:(SEL) selector;

- (void) postObservation:(SEL) selector withObject:(id) object;

- (void) postObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2;

@end

@interface FLObservable : NSObject<FLObservable> {
@private
    NSMutableDictionary* _observers;
}
@end


#define FLSynthesizeObserveable() \
    FLSynthesizeAssociatedPropertyWithLazyGetter_(retain_atomic, observable, setObservable, FLObservable*, FLAutorelease([[FLObservable alloc] init]); \
    - (id)forwardingTargetForSelector:(SEL)aSelector { \
        return self.observable; \
    }
