//
//  FLObservers.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWeakReference.h"

@protocol FLObservable <NSObject>
// observers are __unsafe_unretained
//@property (readonly, strong, nonatomic) NSArray* observers;
- (void) addObserver:(id) observer;
- (void) removeObserver:(id) observer;
- (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor;

// sends SELF as first object always to observer 
- (void) postObservation:(SEL) selector;
- (void) postObservation:(SEL) selector withObject:(id) object;
- (void) postObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2;

- (BOOL) postQuestion:(SEL) selector;
- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer;
- (BOOL) postQuestion:(SEL) selector defaultAnswer:(BOOL) answer withObject:(id) object;

@end

@interface FLObservable : NSObject<FLObservable> {
@private
    NSMutableArray* _observers;
    FLCallbackNotifier* _removeObserver;
}
@end

@protocol FLObserver <NSObject>
@optional
- (void) observerableWasDestroyed:(id) observable;
- (void) receiveObservation:(SEL) selector fromObservable:(id) observable;
- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object;
- (void) receiveObservation:(SEL) selector fromObservable:(id) observable withObject:(id) object1 withObject:(id) object2;
@end

typedef void (^FLBlockObserverNotifier)(id sender);
typedef void (^FLBlockObserverNotifierWithObject)(id sender, id object);

@interface FLBlockObserver : NSObject<FLObserver> {
@private
    SEL _subscribedEvent;
    FLBlockObserverNotifier _block;
    FLBlockObserverNotifierWithObject _blockWithObject;
}

+ (id) blockObserver:(SEL) event block:(FLBlockObserverNotifier) block;
+ (id) blockObserver:(SEL) event blockWithObject:(FLBlockObserverNotifier) block;

@end


//#define FLSynthesizeObserveable(__MEMBER_NAME__) \
//    - (FLObservers*) observers { \
//        if(!__MEMBER_NAME__) __MEMBER_NAME__ = [[FLObservers alloc] init]; \
//        return __MEMBER_NAME__; \
//    } \
//    - (void) addObserver:(id) observer { \
//        [self.observers addObserver:observer]; \
//    } \
//    - (void) removeObserver:(id) observer { \
//        if(__MEMBER_NAME__) [__MEMBER_NAME__ removeObserver:observer]; \
//    } \
//    - (BOOL) visitObservers:(void (^)(id observer, BOOL* stop)) visitor { \
//        return (__MEMBER_NAME__) ? [__MEMBER_NAME__ visitObservers:visitor] : NO; \
//    }


/*
    @interface Foo : NSObject<FLObservable> {
    @private
        FLObservers* __MEMBER_NAME__;
    }
    @end
    
    @implementation Foo
    FLSynthesizeObservers();
    
    - (void) anyMethod {

        BOOL wasStopped = [self.observers visitObservers:^(id observer, BOOL* stop) {
            [observer hello];
        };
        
        if(stopped) {
            [self ohNoes];
        }
    }
    
    @end

*/