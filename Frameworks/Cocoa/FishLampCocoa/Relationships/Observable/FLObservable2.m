//
//  FLObservable2.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable2.h"

@interface FLObserverEvent : NSObject {
@private    
    __unsafe_unretained id _target;
    SEL _action;
}
@property (readwrite, assign) id target;
@property (readwrite, assign) SEL action;

+ (FLObserverEvent*) observerEvent:(id) target action:(SEL) action;

@end

@implementation FLObserverEvent 

synthesize_(target);
synthesize_(action);

+ (id) observerEvent {
    return autorelease_([[[self class] alloc] init]);
}

+ (FLObserverEvent*) observerEvent:(id) target action:(SEL) action {
    FLObserverEvent* event = [FLObserverEvent observerEvent];
    event.target = target;
    event.action = action;
    return event;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { -[%@ %@] }", [super description], NSStringFromClass(_target), NSStringFromSelector(_action)]; 
}

@end

@interface FLObservable2 ()
@property (readwrite, strong) NSMutableDictionary* observers;
@end

@implementation FLObservable2

synthesize_(observers);

- (id) init {
    self = [super init];
    if(self) {
    
    }
    return self;
}

- (void) postObservationForEvent:(id) event {
    NSMutableArray* array = [_observers objectForKey:event];
    if(array) {
        for(int i = array.count - 1; i >= 0; i--) {
            FLObserverEvent* observer = [array objectAtIndex:i];
            FLPerformSelector1(observer.target, observer.action, self);
        }
    }
}

- (void) addObserver:(id) observer forEvent:(id) event eventHandler:(SEL) handler {
    @synchronized(self) {
        if(!self.observers) {
            self.observers = [NSMutableDictionary dictionary];
        }
        
        NSMutableArray* observers = [_observers objectForKey:event];
        if(!observers) {
            observers = [NSMutableArray array];
            [_observers setObject:observers forKey:event];
        }
        
        [observers addObject:[FLObserverEvent observerEvent:observer action:handler]];
    }
}


#if FL_MRC
- (void) dealloc {

    [_observers release];
    [super dealloc];
}
#endif


- (void) removeObserver:(id) observer {
    @synchronized(self) {
        for(NSMutableArray* array in _observers.objectEnumerator) {
            for(int i = array.count - 1; i >=0; i--) {
                FLObserverEvent* event = [array objectAtIndex:i];
                if(event.target == observer) {
                    [array removeObjectAtIndex:i];
                }
            }
        }
    }
}

- (void) removeObserver:(id) observer forEvent:(id) event {
    @synchronized(self) {
        NSMutableArray* array = [_observers objectForKey:event];
        if(array) {
            for(int i = array.count - 1; i >=0; i--) {
                FLObserverEvent* theObserver = [array objectAtIndex:i];
                if(theObserver.target == observer) {
                    [array removeObjectAtIndex:i];
                }
            }
        }
    }
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ observers: %@", [super description], [_observers description]];
}

@end
