//
//  NSObject+FLArrangeable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSObject+FLArrangeable.h"
#import <objc/runtime.h>
static void * const kArrangeableObjectKey = (void*)&kArrangeableObjectKey;

@interface FLArrangeableObjectState : NSObject {
@private
    FLArrangeableState _arrangeableState;
}
+ (FLArrangeableObjectState*) arrangebleObjectState;
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;
@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets; // deltas from arrangement.arrangeableInsets
@property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode;
@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;
@end

@implementation FLArrangeableObjectState
+ (FLArrangeableObjectState*) arrangebleObjectState {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}

@synthesize arrangeableState;
@dynamic arrangeableInsets;
@dynamic arrangeableFillMode;
@dynamic arrangeableWeight;
FLSynthesizeStructProperty(arrangeableInsets, setFrameInsets, FLEdgeInsets, _arrangeableState);
FLSynthesizeStructProperty(arrangeableFillMode, setFrameFillBehavior, FLArrangeableFillMode, _arrangeableState);
FLSynthesizeStructProperty(arrangeableWeight, setFrameWeight, FLArrangeableWeight, _arrangeableState);
@end

/*
@property (readwrite, strong, nonatomic) FLArrangeableObjectState* arrangeableState;
- (FLArrangeableObjectState*) arrangeableStateObjectCreatedIfNeeded;
*/

@implementation NSObject (FLArrangeable)

- (FLArrangeableObjectState*) arrangeableStateObject {
    return objc_getAssociatedObject(self, kArrangeableObjectKey);
}

- (void) setArrangeableStateObject:(FLArrangeableObjectState*) object {
    objc_setAssociatedObject(self, kArrangeableObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FLArrangeableObjectState*) arrangeableStateObjectCreatedIfNeeded {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    if(!object) {
        object = [FLArrangeableObjectState arrangebleObjectState];
        self.arrangeableStateObject = object;
    }
    
    return object;
}

- (FLEdgeInsets) arrangeableInsets {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    return object ? object.arrangeableInsets : FLEdgeInsetsZero;
}

- (void) setFrameInsets:(FLEdgeInsets)arrangeableInsets {
    FLArrangeableObjectState* object = [self arrangeableStateObjectCreatedIfNeeded];
    object.arrangeableInsets = arrangeableInsets;
}

- (FLArrangeableFillMode) arrangeableFillMode {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    return object ? object.arrangeableFillMode : FLArrangeableFillModeNone;
}

- (void) setFrameFillBehavior:(FLArrangeableFillMode) mask {
    FLArrangeableObjectState* object = [self arrangeableStateObjectCreatedIfNeeded];
    object.arrangeableFillMode = mask;
}

- (FLArrangeableWeight) arrangeableWeight {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    return object ? object.arrangeableWeight : FLArrangeableWeightNormal;
}

- (void) setFrameWeight:(FLArrangeableWeight) weight {
    FLArrangeableObjectState* object = [self arrangeableStateObjectCreatedIfNeeded];
    object.arrangeableWeight = weight;
}

- (FLArrangeableState) arrangeableState {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    return object ? object.arrangeableState : FLArrangeableStateZero;
}

- (void) setArrangeableState:(FLArrangeableState) state {
    FLArrangeableObjectState* object = [self arrangeableStateObjectCreatedIfNeeded];
    object.arrangeableState = state;
}


@end
