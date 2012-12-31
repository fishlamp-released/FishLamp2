//
//  FLObservable2.m
//  FLCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"
#import "FLDispatchQueue.h"

NSString* const FLObserverAllEvents = @"*";

@interface FLObserverTarget : NSObject {
@private    
    id _observer;
    SEL _selector;
    FLObservableBlock _block;
}
@property (readwrite, assign) SEL selector;
@property (readwrite, strong) id observer;
@property (readwrite, copy) FLObservableBlock block;

+ (FLObserverTarget*) observerTarget:(id) observer selector:(SEL) selector;
+ (FLObserverTarget*) observerBlock:(FLObservableBlock) block forTarget:(id) observer;

@end

@implementation FLObserverTarget 

@synthesize observer = _observer;
@synthesize selector = _selector;
@synthesize block = _block;

+ (id) observerTarget {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (FLObserverTarget*) observerTarget:(id) observer selector:(SEL) selector {
    FLObserverTarget* event = [FLObserverTarget observerTarget];
    event.observer = observer;
    event.selector = selector;
    return event;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { -[%@ %@] }", [super description], NSStringFromClass(_observer), NSStringFromSelector(_selector)]; 
}

+ (FLObserverTarget*) observerBlock:(FLObservableBlock) block forTarget:(id) observer {
    FLObserverTarget* event = [FLObserverTarget observerTarget];
    event.observer = observer;
    event.block = block;
    return event;
}

- (void) sendNotification:(id) fromObject 
                    event:(SEL) event 
                parmCount:(int) parmCount 
                    parm1:(id) parm1 
                    parm2:(id) parm2  {
    
    if(_block) {
        _block(fromObject, parm1, parm2);
    } 
    else {
        switch(parmCount) {
            case 0:
                FLPerformSelector1(self.observer,self.selector, fromObject); 
            break;

            case 1:
                FLPerformSelector2(self.observer,self.selector, fromObject, parm1); 
            break;

            case 2:
                FLPerformSelector3(self.observer,self.selector, fromObject, parm1, parm2); 
            break;
        }
    }
}

- (void) clean {
    self.observer = nil;
    self.selector = nil;
    self.block = nil;
}

#if FL_MRC
- (void) dealloc {  
    [_observer release];
    [_block release];
    [super dealloc];
}
#endif
@end


//@interface FLObservable ()
//@property (readwrite, strong, nonatomic) NSMutableDictionary* observers;
//@end

@implementation FLObservable

//@synthesize observers = _observers;

- (id) initWithObservedObject:(id) observed {
    self = [super init];
    if(self) {
        _observed = observed;
    }
    
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
        _observed = self;
    }
    return self;
}

#define FLPostObservationForArray(array, ...) \
    if(array) {  \
        for(id observer in array) { \
            @try {  \
                __VA_ARGS__; \
            } \
            @catch(NSException* ex) {  \
                FLAssertFailed_v(@"Not allowed to throw exceptions from observer: %@", ex.reason);  \
            }  \
        }  \
    }

    
- (void) postObservation:(SEL) event {
    
    if(_observers) {
        @synchronized(self) {
            if(_observers) {
                FLPostObservationForArray(  [_observers objectForKey:NSStringFromSelector(event)], 
                                            [observer sendNotification:_observed event:event parmCount:0 parm1:nil parm2:nil]
                                            );
                
                FLPostObservationForArray(  [_observers objectForKey:FLObserverAllEvents], 
                                            [observer sendNotification:_observed event:event parmCount:0 parm1:nil parm2:nil]
                                            );
            }
        }                    
    }
}

- (void) postObservation:(SEL) event withObject:(id) object {
    
    if(_observers) {
        @synchronized(self) {
            if(_observers) {

                FLPostObservationForArray(  [_observers objectForKey:NSStringFromSelector(event)],
                                            [observer sendNotification:_observed event:event parmCount:1 parm1:object parm2:nil]
                                            );
                                    

                FLPostObservationForArray(  [_observers objectForKey:FLObserverAllEvents],
                                            [observer sendNotification:_observed event:event parmCount:1 parm1:object parm2:nil]
                                            );
            }                  
        }
    }                                    
}

- (void) postObservation:(SEL) event withObject:(id) object1 withObject:(id) object2 {
    
    if(_observers) {
        @synchronized(self) {
            if(_observers) {
                FLPostObservationForArray(  [_observers objectForKey:NSStringFromSelector(event)],
                                            [observer sendNotification:_observed event:event parmCount:2 parm1:object1 parm2:object2]
                                            );

                FLPostObservationForArray(  [_observers objectForKey:FLObserverAllEvents],
                                            [observer sendNotification:_observed event:event parmCount:2 parm1:object1 parm2:object2]
                                            );
            }
        }
    }
}


- (void) addObserver:(FLObserverTarget*) target forKey:(NSString*) key {
    @synchronized(self) {
    
        if(!_observers) {
            _observers = [[NSMutableDictionary alloc] init];
        }
        
        NSMutableArray* targets = [_observers objectForKey:key];
        if(!targets) {
            targets = [NSMutableArray array];
            [_observers setObject:targets forKey:key];
        }
        
        [targets addObject:target];
    }
}

- (void) addObserver:(id) observer forEvent:(SEL) event withSelector:(SEL) selector  {
    [self addObserver:[FLObserverTarget observerTarget:observer selector:selector] forKey:NSStringFromSelector(event)];
}

- (void) addObserver:(id) observer forEvent:(SEL) event {
    [self addObserver:[FLObserverTarget observerTarget:observer selector:event] forKey:NSStringFromSelector(event)];
}

- (void) addObserver:(id) observer {
    [self addObserver:[FLObserverTarget observerTarget:observer selector:nil] forKey:FLObserverAllEvents];
}

- (void) addObserver:(id) observer forEvent:(SEL) event withBlock:(FLObservableBlock) block {
    [self addObserver:[FLObserverTarget observerBlock:block forTarget:observer] forKey:NSStringFromSelector(event)];
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
                FLObserverTarget* target = [array objectAtIndex:i];

                if([target observer] == observer) {
                    [target clean];
                    [array removeObjectAtIndex:i];
                }
            }
        }
    }
}

- (void) removeObserver:(id) observer forEvent:(SEL) event {
    @synchronized(self) {
        NSMutableArray* array = [_observers objectForKey:NSStringFromSelector(event)];
        if(array) {
            for(int i = array.count - 1; i >=0; i--) {
                FLObserverTarget* target = [array objectAtIndex:i];
                if([target observer] == observer) {
                    [target clean];
                    [array removeObjectAtIndex:i];
                }
            }
        }
    }
}

- (NSString*) description {

    if(_observers && _observers.count) {
        return [NSString stringWithFormat:@"%@ {\r\nobservers: %@\r\n}", [super description], [_observers description]];
    }
    
    return [super description];
}

@end



