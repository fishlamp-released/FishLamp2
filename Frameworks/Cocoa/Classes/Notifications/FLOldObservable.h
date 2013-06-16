//
//  FLObservable.h
//  FLCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

//#import "FLCocoaRequired.h"
//#import "FLBatchDictionary.h"
//
//@class FLSelector;
//@class FLObservableEvent;
//
//typedef void (^FLObservableBlock)(FLObservableEvent* event);
//
//@protocol FLObservable <NSObject>
//@optional
//
//@property (readonly, strong) id<FLObservable> observable;
//
///// gets all event selectors (if the observer implements them)
///// to receive ALL events define method in FLObservableObserver.
//- (void) addObserver:(id) observer; 
//
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event;
//
///// observe a specific event and use a different selector to respond to it.
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event 
//        withSelector:(SEL) selector ; 
//
///// observe a specific event and use a block to respond to it.
//- (void) addObserver:(id) observer 
//            forEvent:(SEL) event 
//           withBlock:(FLObservableBlock) block; 
//
//- (void) removeObserver:(id) observer 
//               forEvent:(SEL) event;
//
///// this is slow.
//- (void) removeObserver:(id) observer;
//
////
//// for subclasses
////
//
//- (void) sendMessage:(SEL) selector;
//
//- (void) sendMessage:(SEL) selector 
//              withObject:(id) object;
//
//- (void) sendMessage:(SEL) selector 
//              withObject:(id) object1 
//              withObject:(id) object2;
//
//- (void) postObservableEvent:(FLObservableEvent*) event;
//
//@end
//
//@protocol FLObservableObserver <NSObject>
///// you will get ALL the events. 
//- (void) handleObservableEvent:(FLObservableEvent*) event;
//@end
//
//@interface FLObservable : NSObject<FLObservable> {
//@private
//    FLMutableBatchDictionary* _observers;
//    NSMutableArray* _catchAllObservers;
//    __unsafe_unretained id _observed; // set to 'self' by default.
//}
//- (id) initWithObservedObject:(id) observed;
//
//@end
//
//
//
//#define FLObservableEventMaxArguments 3
//@interface FLObservableEvent : FLSelector {
//@private
//    id _arguments[FLObservableEventMaxArguments];
//}
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender;
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender withObject:(id) object;
//+ (id) observableEvent:(SEL) eventSelector fromSender:(id) sender withObject:(id) object1 withObject:(id) object2;
//
//- (id) argumentAtIndex:(NSUInteger) idx;
//
//- (BOOL) sendEventToTarget:(id) target;
//- (BOOL) sendEventToTarget:(id) target 
//   withSubstitutedSelector:(SEL) selector;
//
//@end
//
//typedef void (^FLObserverBlock)(id object, id data);
//typedef void (^FLObserverEventBlock)(int event, id object, id data);
//
//enum {
//    FLObservableEventAllEvents = 0
//};
//
//typedef NSUInteger FLObservableEventID;
//
//@protocol FLObservable2 <NSObject>
//
////- (void) addObserver:(id) object forEvent:(FLObservableEventID) event withSelector:(SEL) selector;
//- (void) addObserver:(id) object forEvent:(FLObservableEventID) event withBlock:(FLObserverBlock) block;
//
////- (void) addObserver:(id) object forAllEventsWithSelector:(SEL) selector; // @selector(name:data:eventID:)
//- (void) addObserver:(id) object forAllEvents:(FLObserverEventBlock) block; // @selector(name:data:eventID:)
//
//- (void) removeObserver:(id) object forEvent:(FLObservableEventID) event;
//- (void) removeObserver:(id) object;
//
//- (void) postObservableEvent:(FLObservableEventID) event;
//- (void) postObservableEvent:(FLObservableEventID) event withData:(id) data;
//
//@end
//
//@interface FLObservable2 : NSObject<FLObservable2> {
//@private
//    FLMutableBatchDictionary* _observers;
//}
//@end

/*


//make sure you set the observed object when mixing in like this:

- (id) init {
    self = [super init];
    if(self) {
        _observable = [[FLObservable alloc] initWithObservedObject:self];
    }
    
    return self;
}

// Example of "mixing in" observable. (assumes "observable" property implemeted)

- (id)forwardingTargetForSelector:(SEL)aSelector { 
    if([self.observable respondsToSelector:aSelector]) {
        return self.observable;
    }
    
    return self;
}

*/

#define FLSynthesizeObservable() \
    FLSynthesizeLazyGetterWithInit(observable, FLObservable, [[FLObservable alloc] initWithObservedObject:self]) \
    - (id)forwardingTargetForSelector:(SEL)aSelector { \
        if([self.observable respondsToSelector:aSelector]) { \
            return self.observable; \
        } \
        return self; \
    }
    


