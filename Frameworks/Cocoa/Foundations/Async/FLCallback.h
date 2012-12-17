//
//  FLCallback.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

typedef void (^FLCallbackBlock)(id sender);

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

- (void) invoke:(id) sender;

@end
