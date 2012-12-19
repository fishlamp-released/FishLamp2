//
//  FLOldObservable.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLCocoaRequired.h"
//
//#import "FLWeakReference.h"
//
//#import "FLObservable2.h"
//
//@protocol FLOldObservable <NSObject>
//// observable are __unsafe_unretained
//@optional
//
//- (void) addObserver:(id) observer;
//- (void) removeObserver:(id) observer;
//- (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor;
//
//// sends SELF as first object always to observer 
//- (void) postObservation:(SEL) selector;
//- (void) postObservation:(SEL) selector withObject:(id) object;
//- (void) postObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2;
//
//- (BOOL) postQuestion:(SEL) selector;
//- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer;
//- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer withObject:(id) object;
//
//@end
//
//@interface FLOldObservable : NSObject<FLOldObservable> {
//@private
//    NSMutableArray* _observers;
////    NSArray* _iteratable;
//    
////    FLCallbackNotifier* _removeObserver;
//}
//- (void) addObserver:(id) observer;
//- (void) removeObserver:(id) observer;
//- (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor;
//
//// sends SELF as first object always to observer 
//- (void) postObservation:(SEL) selector;
//- (void) postObservation:(SEL) selector withObject:(id) object;
//- (void) postObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2;
//
//- (BOOL) postQuestion:(SEL) selector;
//- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer;
//- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer withObject:(id) object;
//
//@end
//
//@protocol FLObserver <NSObject>
//@optional
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable;
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object;
//- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object1 withObject:(id) object2;
//@end
//
//typedef void (^FLBlockObserverNotifier)(id sender);
//typedef void (^FLBlockObserverNotifierWithObject)(id sender, id object);
//
//@interface FLBlockObserver : NSObject<FLObserver> {
//@private
//    SEL _subscribedEvent;
//    FLBlockObserverNotifier _block;
//    FLBlockObserverNotifierWithObject _blockWithObject;
//}
//
//+ (id) blockObserver:(SEL) event block:(FLBlockObserverNotifier) block;
//+ (id) blockObserver:(SEL) event blockWithObject:(FLBlockObserverNotifier) block;
//
//@end
//
//
//#define FLSynthesizeOldObserveable() \
//    FLSynthesizeAssociatedPropertyWithLazyGetter_(retain_atomic, observable, setObservable, FLOldObservable*, [FLOldObservable create]); \
//    - (id)forwardingTargetForSelector:(SEL)aSelector { \
//        return self.observable; \
//    }
    
//    - (void) addObserver:(id) observer { \
//        [self.observable addObserver:observer]; \
//    } \
//    - (void) removeObserver:(id) observer { \
//        if(__MEMBER_NAME__) [__MEMBER_NAME__ removeObserver:observer]; \
//    } \
//    - (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor { \
//        return (__MEMBER_NAME__) ? [__MEMBER_NAME__ visitObservers:visitor] : NO; \
//    }


/*
    @interface Foo : NSObject<FLOldObservable> {
    @private
        FLOldObservable* __MEMBER_NAME__;
    }
    @end
    
    @implementation Foo
    FLSynthesizeObservers();
    
    - (void) anyMethod {

        BOOL wasStopped = [self.observable visitObservers:^(id observer, BOOL* stop) {
            [observer hello];
        };
        
        if(stopped) {
            [self ohNoes];
        }
    }
    
    @end

*/