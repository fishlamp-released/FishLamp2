//
//  FLObservers.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"
#import "FLDeallocNotifier.h"
#import "FLDeletedObjectReference.h"
#import "FLAnswerable.h"
#import "FLCollectionIterator.h"

@interface FLUnretainedObserver : NSObject<FLObserver> {
@private
    FLWeakReference* _observer;
    FLWeakReference* _observing;
}

- (id) initWithObserver:(id) observer isObserving:(id) observedObject;
+ (id) unretainedObserver:(id) observer isObserving:(id) observedObject;
@end


//@implementation NSObject (FLObserver)
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object {
//    [self performIfRespondsToSelector:selector
//                       withObject:observable
//                       withObject:object];
//}
//
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable {
//    [self performIfRespondsToSelector:selector withObject:observable];
//}
//
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object1 withObject:(id) object2 {
//    [self performIfRespondsToSelector:selector
//                       withObject:observable
//                       withObject:object1
//                       withObject:object2];
//}
//@end


@interface FLObservable ()
@property (readwrite, strong) NSArray* observers;
@end

@implementation FLObservable

synthesize_(observers);

- (void) observerDied:(FLDeletedObjectReference*) ref {
    [self removeObserver:ref.deletedObject];
}

- (void) addObserver:(id) observer {
    @synchronized(self) {
        if(!self.observers) {
            self.observers = [NSMutableArray array];
        }
   
//        [observer addDeallocListener:self action:@selector(observerDied:)];
//       [_observers addObject:[FLUnretainedObserver unretainedObserver:observer isObserving:self]];
 
        [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
                  
//        FLReleaseWithNil_(_iteratable);
    }


}

- (void) removeObserver:(id) observer {
    @synchronized(self) {
        [_observers removeObject:observer];
//        FLReleaseWithNil_(_iteratable);
    }
}

//- (NSArray*) iteratable {
//    NSArray* iteratable = _iteratable;
//    if(!iteratable) {
//        NSArray* observers = self.observers;
//        if(!observers || observers.count == 0) {
//            return nil;
//        }
//        @synchronized(self) {
//            iteratable = _iteratable;
//            if(!iteratable) {
//                _iteratable = [observers copy];
//                iteratable = _iteratable;
//            }
//        }
//    
//    }
//    
//    return iteratable;
//}

- (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor {
    
//    NSArray* observers = self.iteratable;
    BOOL stop = NO;
//    if(observers) {
        for(id observer in [_observers forwardIterator]) {
            visitor([observer nonretainedObjectValue], &stop);
            
            if(stop) {
                break;
            }
        }
//    }
    
    return stop;
}

- (void) dealloc {
#if FL_MRC
//    [_observers release];
    [super dealloc];
#endif
}

- (void) postObservation:(SEL) selector {

//    NSArray* observers = self.iteratable;
//    if(observers) {
        for(id observer in [_observers forwardIterator]) {
            @try {
                if( !FLPerformSelector1([observer nonretainedObjectValue], selector, self)) {
                    FLPerformSelector1([observer nonretainedObjectValue], @selector(receiveObservation:fromObservable:), self);
                }
            }
            @catch(NSException* ex) {
                FLAssertFailed_v(@"Not allowed to throw exceptions from observer.");
            }
        }
//    }
}

- (void) postObservation:(SEL) selector withObject:(id) object {

//    NSArray* observers = self.iteratable;
//    if(observers) {
        for(id observer in [_observers forwardIterator]) {
            @try {
                if( !FLPerformSelector2([observer nonretainedObjectValue], selector, self, object)) {
                    FLPerformSelector2([observer nonretainedObjectValue], @selector(receiveObservation:fromObservable:), self, object);
                }
            }
            @catch(NSException* ex) {
                FLAssertFailed_v(@"Not allowed to throw exceptions from observer.");
            }
        }
//    }
}

- (void) postObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2 {

//    NSArray* observers = self.iteratable;
//    if(observers) {
        for(id observer in [_observers forwardIterator]) {
            @try {
                if( !FLPerformSelector3([observer nonretainedObjectValue], selector, self, object1, object2)) {
                    FLPerformSelector3([observer nonretainedObjectValue], @selector(receiveObservation:fromObservable:), self, object1, object2);
                }            
            }
            @catch(NSException* ex) {
                FLAssertFailed_v(@"Not allowed to throw exceptions from observer.");
            }
        }
//    }
}

- (BOOL) postQuestion:(SEL) selector {
    FLAnswerable* answer = [FLAnswerable answerable];
    [self postObservation:selector withObject:answer];
    
    return answer.answer;
}

- (BOOL) postQuestion:(SEL) selector 
        defaultAnswer:(BOOL) defaultAnswer {

    FLAnswerable* answer = [FLAnswerable answerable:defaultAnswer];
    [self postObservation:selector withObject:answer];
    
    return answer.answer;
}

- (BOOL) postQuestion:(SEL) selector 
        defaultAnswer:(BOOL) defaultAnswer 
           withObject:(id) object {

    FLAnswerable* answer = [FLAnswerable answerable:defaultAnswer];
    [self postObservation:selector withObject:answer withObject:object];
    return answer.answer;
}

@end

@implementation FLUnretainedObserver

- (void) someoneDied:(id) sender {
    id theObject = _observing.object;
    [theObject removeObserver:self];
}

- (id) initWithObserver:(id) observer isObserving:(id) observedObject {
    self = [super init];
    if(self) {
        _observer = [FLWeakReference weakReference:observer];
        _observing = [FLWeakReference weakReference:observedObject];
        
        [_observer addNotifierWithTarget:self action:@selector(someoneDied:)];
        [_observing addNotifierWithTarget:self action:@selector(someoneDied:)];
    }

    return self;
}

+ (id) unretainedObserver:(id) observer isObserving:(id) observedObject {
    return autorelease_([[[self class] alloc] initWithObserver:observer isObserving:observedObject]);
}

- (void) receiveObservation:(SEL) selector fromObservable:(id) observable  {
    id theObject = _observing.object;

    if( !FLPerformSelectorWithObject(theObject, selector, observable)) {
        FLPerformSelectorWithObject(theObject, @selector(receiveObservation:fromObservable:), observable);
    }
}

- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object {
    id theObject = _observing.object;

    if( !FLPerformSelectorWithTwoObjects(theObject, selector, observable, object)) {
        FLPerformSelectorWithTwoObjects(theObject, @selector(receiveObservation:fromObservable:), observable, object);
    }
}

- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object1 withObject:(id) object2 {
    id theObject = _observing.object;

    if( !FLPerformSelectorWithThreeObjects(theObject, selector, observable, object1, object2)) {
        FLPerformSelectorWithThreeObjects(theObject, @selector(receiveObservation:fromObservable:), observable, object1, object2);
    }
}

- (BOOL) isEqual:(id) object {
    return self == object || _observer == object || [_observer isEqual:object];
}

- (NSUInteger)hash {
    return [_observer hash];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if(![super respondsToSelector:aSelector]) {
        id theObject = _observing.object;

        return [theObject respondsToSelector:aSelector];
    }

    return YES;
}

#if FL_MRC
- (void) dealloc {
    [_observer release];
    [_observing release];
    [super dealloc];
}
#endif


@end


//@implementation FLObservable
//
//@synthesize observers = _observers;
//
//- (void) addObserver:(id) observer {
//    @synchronized(self) {
//        if(!_observers) {
//            _observers = [[NSMutableArray alloc] init];
//        }
//        [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
//    }
//}
//
//- (void) removeObserver:(id) observer {
//    @synchronized(self) {
//        [_observers removeObject:[NSValue valueWithNonretainedObject:observer]];
//    }
//}
//
//- (void) dealloc {
//    [self postObservation:@selector(observerableWasDestroyed:)];
//
//#if FL_MRC
//    [_observers release];
//    [super dealloc];
//#endif
//}
//
//- (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor {
//    
//    BOOL stop = NO;
//    
//    NSInteger current = 0;
//    BOOL started = NO;
//    
//    while(YES) {
//    
//        id observer = nil;
//        @synchronized(self) {
//        
//            NSUInteger count = _observers.count;
//            if(count == 0) {
//                break;
//            }
//            
//            if(!started || current > count) {
//                current = count - 1;
//                started = YES;
//            }
//            
//            if(current-- >= 0) {
//                observer = [_observers objectAtIndex:current];
//            }
//        }
//    
//        if(!observer) {
//            break;
//        }
//
//        visitor(observer, &stop);
//    }
//
//    return stop;
//}
//
//- (void) postObservation:(SEL) selector withObject:(id) object{
//    [self visitObservers:^(id observer, BOOL *stop) {
//        @try {
//            FLPerformSelectorWithObject(observer, selector, object);
//        }
//        @catch(NSException* ex) {
//            FLAssertFailed_v(@"Not allowed to throw exceptions from observer.");
//        }
//    }];
//}
//
//- (void) postObservation:(SEL) selector withObject:(id) object withObject:object2{
//    [self visitObservers:^(id observer, BOOL *stop) {
//        @try {
//            FLPerformSelectorWithObjectAndObject(observer, selector, object, object2);
//        }
//        @catch(NSException* ex) {
//            FLAssertFailed_v(@"Not allowed to throw exceptions from observer.");
//        }
//    }];
//}
//
//@end


//@implementation FLSimpleNotifier (FLObserveable)
//
//- (void) postObservation:(SEL) selector withObject:(id) object {
//}
//
//- (void) postObservation:(SEL) selector {
//}
//
//@end