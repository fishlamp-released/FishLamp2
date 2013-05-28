////
////  FLObservable2.m
////  FLCore
////
////  Created by Mike Fullerton on 11/14/12.
////  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "FLObservable.h"
//#import "FLAsyncQueue.h"
//
//#define FLEventKeyFromSelector(SEL) [NSValue valueWithPointer:SEL]    
//
//@interface FLObserverTarget : NSObject {
//@private    
//    __unsafe_unretained id _target;
//    SEL _selector;
//    FLObservableBlock _block;
//}
//@property (readonly, assign) SEL selector;
//@property (readonly, assign) id target;
//@property (readonly, copy) FLObservableBlock block;
//
//+ (FLObserverTarget*) observerTarget:(id) target withSelector:(SEL) selector;
//+ (FLObserverTarget*) observerTarget:(id) target withBlock:(FLObservableBlock) block;
//@end
//
//@interface FLObserverTarget ()
//@property (readwrite, assign) SEL selector;
//@property (readwrite, assign) id target;
//@property (readwrite, copy) FLObservableBlock block;
//@end
//
//@implementation FLObserverTarget 
//
//@synthesize target = _target;
//@synthesize selector = _selector;
//@synthesize block = _block;
//
//+ (id) observerTarget {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (FLObserverTarget*) observerTarget:(id) target withSelector:(SEL) selector {
//    FLObserverTarget* event = [FLObserverTarget observerTarget];
//    event.target = target;
//    event.selector = selector;
//    return event;
//}
//
//+ (FLObserverTarget*) observerTarget:(id) target withBlock:(FLObservableBlock) block {
//    FLObserverTarget* event = [FLObserverTarget observerTarget];
//    event.target = target;
//    event.block = block;
//    return event;
//}
//
//- (NSString*) description {
//    return [NSString stringWithFormat:@"%@ { -[%@ %@] }", [super description], NSStringFromClass(_target), NSStringFromSelector(_selector)]; 
//}
//
//+ (FLObserverTarget*) observerTargetWithBlock:(FLObservableBlock) block forTarget:(id) target {
//    FLObserverTarget* event = [FLObserverTarget observerTarget];
//    event.target = target;
//    event.block = block;
//    return event;
//}
//
//- (void) clean {
//    self.target = nil;
//    self.selector = nil;
//    self.block = nil;
//}
//
//#if FL_MRC
//- (void) dealloc {  
////    [_target release];
//    [_block release];
//    [super dealloc];
//}
//#endif
//@end
//
//
//@implementation FLObservable
//
//- (id<FLObservable>) observable {
//    return self;
//}
//
//- (id) initWithObservedObject:(id) observed {
//    self = [super init];
//    if(self) {
//        _observed = observed;
//    }
//    
//    return self;
//}
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _observed = self;
//    }
//    return self;
//}
//    
//#if FL_MRC
//- (void) dealloc {
//    [_observers release];
//    [_catchAllObservers release];
//    [super dealloc];
//}
//#endif
//
//- (void) postObservableEvent:(FLObservableEvent*) event {
//    
//    if(_observers || _catchAllObservers) {
//        @synchronized(self) {
//            @try {  
//                if(_observers) {
//                    for(FLObserverTarget* target in [_observers objectsForKey:FLEventKeyFromSelector(event.selector)]) {
//                    
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if(target.block) {
//                                target.block(event);
//                            } 
//                            else {
//                                SEL sel = target.selector ? target.selector : event.selector;
//                                [event sendEventToTarget:target.target withSubstitutedSelector:sel];
//                            }           
//                        });
//                    }
//                }
//                
//                if(_catchAllObservers) {
//                    for(NSValue* targetHolder in _catchAllObservers) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            id target = [targetHolder nonretainedObjectValue];
//                            [event sendEventToTarget:target];
//                            FLPerformSelector1(target, @selector(handleObservableEvent:), event);
//                        });
//                    }
//                }
//            } 
//            @catch(NSException* ex) {  
//                FLAssertFailedWithComment(@"Not allowed to throw exceptions from object: %@", ex.reason);  
//            } 
//        };
//    }
//}                         
//              
//- (void) sendMessage:(SEL) event {
//    [self postObservableEvent:[FLObservableEvent observableEvent:event fromSender:self]];
//}
//
//- (void) sendMessage:(SEL) event 
//              withObject:(id) object {
//    [self postObservableEvent:[FLObservableEvent observableEvent:event fromSender:self withObject:object]];
//}
//
//- (void) sendMessage:(SEL) event 
//              withObject:(id) object1 
//              withObject:(id) object2 {
//
//    [self postObservableEvent:[FLObservableEvent observableEvent:event fromSender:self withObject:object1 withObject:object2]];
//}
//
//- (void) addObserver:(FLObserverTarget*) target forKey:(id) key {
//    
//    @synchronized(self) {
//        if(!_observers) {
//            _observers = [[FLMutableBatchDictionary alloc] init];
//        }
//        
//        [_observers addObject:target forKey:key];
//    };
//}
//
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event 
//        withSelector:(SEL) selector  {
//
//    [self addObserver:[FLObserverTarget observerTarget:observer withSelector:selector] 
//               forKey:FLEventKeyFromSelector(event)];
//}
//
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event {
//            
//    [self addObserver:[FLObserverTarget observerTarget:observer withSelector:event] 
//               forKey:FLEventKeyFromSelector(event)];
//}
//
//- (void) addObserver:(id) observer {
//
//    @synchronized(self) {
//        if(!_catchAllObservers) {
//            _catchAllObservers = [[NSMutableArray alloc] init];
//        }
//        
//        [_catchAllObservers addObject:[NSValue valueWithNonretainedObject:observer]];
//    };
//}       
//
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event 
//           withBlock:(FLObservableBlock) block {
//
//    [self addObserver:[FLObserverTarget observerTarget:observer withBlock:block] 
//               forKey:FLEventKeyFromSelector(event)];
//}
//
//- (void) removeObserver:(id) observer {
//    @synchronized(self){
//        [_observers removeObject:observer];
//        [_catchAllObservers removeObject:observer];
//    };
//}
//
//- (void) removeObserver:(id) observer 
//               forEvent:(SEL) event {
//    @synchronized(self) {
//        [_observers removeObject:observer forKey:FLEventKeyFromSelector(event)];
//    };
//}
//
//- (NSString*) description {
//
//    if(_observers) {
//        return [NSString stringWithFormat:@"%@ {\r\nobservers: %@, catch all observers: %@\r\n}", 
//            [super description], 
//            [_observers description], 
//            [_catchAllObservers description]];
//    }
//    
//    return [super description];
//}
//
//@end
//
//
//
//
//@implementation FLObservableEvent 
//
//- (void) setArgument:(id) arg atIndex:(NSUInteger) idx {
//    FLConfirm(idx < FLObservableEventMaxArguments);
//    FLSetObjectWithRetain(_arguments[idx], arg);
//}
//
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender {
//    FLObservableEvent* event = FLAutorelease([[[self class] alloc] initWithSelector:eventSelector argCount:1]);
//    [event setArgument:sender atIndex: 0];
//    return event;
//}
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender withObject:(id) object {
//    FLObservableEvent* event = FLAutorelease([[[self class] alloc] initWithSelector:eventSelector argCount:2]);
//    [event setArgument:sender atIndex: 0];
//    [event setArgument:object atIndex: 1];
//    return event;
//}
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender withObject:(id) object1 withObject:(id) object2 {
//    FLObservableEvent* event = FLAutorelease([[[self class] alloc] initWithSelector:eventSelector argCount:3]);
//    [event setArgument:sender atIndex: 0];
//    [event setArgument:object1 atIndex: 1];
//    [event setArgument:object2 atIndex: 2];
//    return event;
//}
//
//- (id) argumentAtIndex:(NSUInteger) idx {
//    FLConfirm(idx < FLObservableEventMaxArguments);
//    return _arguments[idx];
//}
//
//#if FL_MRC
//- (void) dealloc {
//    for(int i = 0; i < FLObservableEventMaxArguments; i++) {
//        [_arguments[i] release];
//    }    
//    [super dealloc];
//}
//#endif
//
//- (id) copyWithZone:(NSZone *)zone {
//
//    FLObservableEvent* observable = 
//        [[FLObservableEvent alloc] initWithSelector:self.selector argCount:self.argumentCount];
//    
//    for(int i = 0; i < FLObservableEventMaxArguments; i++) {
//        [observable setArgument:FLCopyWithAutorelease([self argumentAtIndex:i]) atIndex:i];
//    }
//
//    return observable;
//}
//
//- (BOOL) sendEventToTarget:(id) target {
//    return [self sendEventToTarget:target withSubstitutedSelector:self.selector];
//}
//
//- (BOOL) sendEventToTarget:(id) target withSubstitutedSelector:(SEL) selector {
//
//    switch(self.argumentCount) {
//        default:
//            FLAssertFailedWithComment(@"observer event selectors should have 1 - 3 parameters")
//        break;
//
//        case 1:
//            return FLPerformSelector1(target, selector, [self argumentAtIndex:0]); 
//        break;
//
//        case 2:
//            return FLPerformSelector2(target, selector, [self argumentAtIndex:0], [self argumentAtIndex:1]); 
//        break;
//
//        case 3:
//            return FLPerformSelector3(target, selector, [self argumentAtIndex:0], [self argumentAtIndex:1], [self argumentAtIndex:2]); 
//        break;
//    }
//    return NO;
//}
//
//
//
//@end
//
//@interface FLObserverTarget2 : NSObject {
//@private    
//    __unsafe_unretained id _target;
//    SEL _selector;
//    dispatch_block_t _block;
//}
//@property (readonly, assign) SEL selector;
//@property (readonly, assign) id target;
//@property (readonly, copy) dispatch_block_t block;
//
//+ (FLObserverTarget2*) observerTarget:(id) target withSelector:(SEL) selector;
//+ (FLObserverTarget2*) observerTarget:(id) target withBlock:(dispatch_block_t) block;
//@end
//
//@interface FLObserverTarget2 ()
//@property (readwrite, assign) SEL selector;
//@property (readwrite, assign) id target;
//@property (readwrite, copy) dispatch_block_t block;
//@end
//
//@implementation FLObserverTarget2 
//
//@synthesize target = _target;
//@synthesize selector = _selector;
//@synthesize block = _block;
//
//+ (id) observerTarget {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (FLObserverTarget2*) observerTarget:(id) target withSelector:(SEL) selector {
//    FLObserverTarget2* event = [FLObserverTarget observerTarget];
//    event.target = target;
//    event.selector = selector;
//    return event;
//}
//
//+ (FLObserverTarget2*) observerTarget:(id) target withBlock:(dispatch_block_t) block {
//    FLObserverTarget2* event = [FLObserverTarget2 observerTarget];
//    event.target = target;
//    event.block = block;
//    return event;
//}
//
//- (NSString*) description {
//    return [NSString stringWithFormat:@"%@ { -[%@ %@] }", [super description], NSStringFromClass(_target), NSStringFromSelector(_selector)]; 
//}
//
//- (void) clean {
//    self.target = nil;
//    self.selector = nil;
//    self.block = nil;
//}
//
//#if FL_MRC
//- (void) dealloc {  
////    [_target release];
//    [_block release];
//    [super dealloc];
//}
//#endif
//@end
//
//#define FLEventKey(e) [NSNumber numberWithUnsignedInteger:e]
//
//@implementation FLObservable2
//
//- (void) addTarget:(FLObserverTarget2*) target forEvent:(FLObservableEventID) event {
//    @synchronized(self) {
//        if(!_observers) {
//            _observers = [[FLMutableBatchDictionary alloc] init];
//        }
//            
//        [_observers addObject:target forKey:FLEventKey(event)];
//    }
//}
//
//- (void) addObserver:(id) object forEvent:(FLObservableEventID) event withSelector:(SEL) selector {
//    [self addTarget:[FLObserverTarget2 observerTarget:object withSelector:selector] forEvent:event];
//}
//
//- (void) addObserver:(id) object forEvent:(FLObservableEventID) event withBlock:(FLObserverBlock) block {
//    [self addTarget:[FLObserverTarget2 observerTarget:object withBlock:(dispatch_block_t)block] forEvent:event];
//}
//
//- (void) addObserver:(id) object forAllEventsWithSelector:(SEL) selector {
//    [self addTarget:[FLObserverTarget2 observerTarget:object withSelector:selector] forEvent:FLObservableEventAllEvents];
//}
//
//- (void) addObserver:(id) object forAllEvents:(FLObserverEventBlock) block {
//    [self addTarget:[FLObserverTarget2 observerTarget:object withBlock:(dispatch_block_t)block] forEvent:FLObservableEventAllEvents];
//}
//
////- (void) addObserver:(id) object forAllEventsWithBlock:(FLObserverEventBlock) block {
////    [self addTarget:[FLObserverTarget2 observerTarget:object withBlock:block] forEvent:FLObservableEventAllEvents];
////}
//
//- (void) postObservableEvent:(FLObservableEventID) eventID withData:(id) data fromObject:(id) fromObject {
//    
//    if(_observers) {
//        @synchronized(self) {
//            
//            @try {  
//                if(eventID != FLObservableEventAllEvents) {
//                    NSNumber* key = FLEventKey(eventID);
//                    for(FLObserverTarget2* target in [_observers objectsForKey:key]) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            FLObserverBlock block = (FLObserverBlock) target.block;
//                            if(block) {
//                                block(fromObject, data);
//                            } 
//                            else {
//                                FLPerformSelector2(target, target.selector, fromObject, data);
//                            
////                                [target performSelector:target.selector withObject:fromObject withObject:data];
//                            }           
//                        });
//                    }
//                }
//                
//                NSNumber* allKey = FLEventKey(FLObservableEventAllEvents);
//                for(FLObserverTarget2* target in [_observers objectsForKey:allKey]) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        FLObserverEventBlock block = (FLObserverEventBlock) target.block;
//                        if(block) {
//                            block(eventID, fromObject, data);
//                        } 
////                        [target performSelector:target.selector withObject:fromObject withObject:data withObject:allKey];
//                    });
//                }
//            } 
//            @catch(NSException* ex) {  
//                FLAssertFailedWithComment(@"Not allowed to throw exceptions from object: %@", ex.reason);  
//            } 
//        };
//    }
//}                         
//  
//- (void) postObservableEvent:(FLObservableEventID) eventID withData:(id) data {
//    [self postObservableEvent:eventID withData:data fromObject:self];
//}
//
//- (void) removeObserver:(id) observer {
//    @synchronized(self){
//        [_observers removeObject:observer];
//    };
//}
//
//- (void) removeObserver:(id) observer 
//               forEvent:(FLObservableEventID) event {
//    @synchronized(self) {
//        [_observers removeObject:observer forKey:FLEventKey(event)];
//    };
//}
//
//- (void) postObservableEvent:(FLObservableEventID) event {
//    [self postObservableEvent:event withData:nil fromObject:self];
//}
//
//@end
