//
//  FLCallback.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatchable.h"
#import "FLArgumentList.h"

typedef void (^FLCallbackBlock)(FLArgumentList* args);

@interface FLCallback : NSObject {
@private
    FLCallbackBlock _block;
    id _target;
    SEL _action;
}

@property (readonly, strong, nonatomic) id target;
@property (readonly, assign, nonatomic) SEL action;
@property (readonly, copy, nonatomic) FLCallbackBlock callbackBlock;

- (id) initWithTarget:(id) target action:(SEL) action;
- (id) initWithBlock:(FLCallbackBlock) block;

+ (id) callbackWithTarget:(id) target action:(SEL) action;
+ (id) callbackWithBlock:(FLCallbackBlock) block;

- (void) perform;
- (void) performWithObject:(id) object;
- (void) performWithObject:(id) object1 withObject:(id) object2;
- (void) performWithObject:(id) object1 withObject:(id) object2 withObject:(id) object3;
@end


@interface FLStashedCallback : FLCallback<FLDispatchable> {
@private
    FLArgumentList* _arguments;
}

@property (readonly, strong, nonatomic) FLArgumentList* arguments;

- (id) initWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments;
- (id) initWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments;

+ (id) callbackWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments;
+ (id) callbackWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments;

@end