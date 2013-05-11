//
//  FLCallback.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLSelectorPerforming.h"

//
// simple callback struct
//

typedef struct {
    __unsafe_unretained id target;
	SEL action;
} FLCallback_t;

extern const FLCallback_t FLCallbackZero;

NS_INLINE
FLCallback_t FLCallbackMake(id target, SEL action) {
   FLCallback_t cb = { target, action };
   return cb;
}

NS_INLINE
BOOL FLCallbackIsNotNil(FLCallback_t cb) {
	return cb.target && cb.action;
}

NS_INLINE
BOOL FLCallbackIsNil(FLCallback_t cb) {
	return !cb.target || !cb.action;
}

NS_INLINE
BOOL FLCallbackPerform(FLCallback_t callback, id withObject) {
	return FLPerformSelector0(callback.target, callback.action);
}

NS_INLINE
BOOL FLCallbackPerform1(FLCallback_t callback, id withObject) {
	return FLPerformSelector1(callback.target, callback.action, withObject);
}

NS_INLINE
BOOL FLCallbackPerform2(FLCallback_t callback, id withObject1, id withObject2) {
	return FLPerformSelector2(callback.target, callback.action, withObject1, withObject2);
}

NS_INLINE
BOOL FLCallbackPerform3(FLCallback_t callback, id withObject1, id withObject2, id withObject3) {
	return FLPerformSelector3(callback.target, callback.action, withObject1, withObject2, withObject3);
}

//
// callback objects
//

@interface FLCallback : NSObject {
@private
}

- (id) initWithTarget:(id) target action:(SEL) action;

+ (id) callbackWithTarget:(id) target action:(SEL) action;

- (id) target;
- (void) setTarget:(id) target;

- (SEL) action;
- (void) setAction:(SEL) action;

- (BOOL) perform;
- (BOOL) performWithObject:(id) object;
- (BOOL) performWithObject:(id) object1 withObject:(id) object2;
- (BOOL) performWithObject:(id) object1 withObject:(id) object2 withObject:(id) object3;
@end


@interface FLCallbackWithUnretainedTarget : FLCallback {
@private
    __unsafe_unretained id _target;
    SEL _action;
}

@property (readwrite, assign) id target;
@property (readwrite, assign) SEL action;

@end

//@interface FLStashedCallback : FLCallback<FLAsyncWorker> {
//@private
//    FLArgumentList* _arguments;
//}
//
//@property (readonly, strong, nonatomic) FLArgumentList* arguments;
//
//- (id) initWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments;
//- (id) initWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments;
//
//+ (id) callbackWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments;
//+ (id) callbackWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments;
//
//@end

