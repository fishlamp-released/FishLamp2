//
//  FLCallback.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLArgumentList.h"

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

