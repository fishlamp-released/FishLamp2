//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLObservable.h"
#import "FLBroadcaster.h"

@implementation FLObservable 

FLSynthesizeLazyGetter(observers, FLBroadcaster*, _observers, FLBroadcaster)

#if FL_MRC
- (void)dealloc {
	[_observers release];
	[super dealloc];
}
#endif

- (BOOL) hasListener:(id) listener {
    return [self.observers hasListener:listener];
}

- (void) addObserver:(id<FLObjectProxy>) observer {
    [self.observers addObserver:observer];
}

- (void) removeObserver:(id) listener {
    [self.observers removeObserver:listener];
}


@end
/*
#if REFACTOR

@interface NSObject (FLObservationSending)

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

// sending

- (BOOL) sendObservation:(SEL) selector
              toObserver:(id) observer;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3
              withObject:(id) object4;

@end

@protocol FLObservable <NSObject>
@property (readwrite, assign, nonatomic) id observer;

- (BOOL) sendObservation:(SEL) messageSelector;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;
@end

@interface FLObservable : NSObject<FLObservable> {
@private
    __unsafe_unretained id _observer;
}


@end

#endif

#if REFACTOR

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

#endif
*/