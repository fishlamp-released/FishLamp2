//
//  NSObject+FLArrangeable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSObject+FLArrangeable.h"

static void * const kArrangeableObjectKey = (void*)&kArrangeableObjectKey;

@interface FLArrangeableObjectState : NSObject {
@private
    FLArrangeableState _arrangeableState;
    FLEdgeInsets _arrangeableInsets;
    FLArrangeableGrowMode _arrangeableGrowMode;
    FLArrangeableWeight _arrangeableWeight;

}
+ (FLArrangeableObjectState*) arrangebleObjectState;
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;
@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets; // deltas from arrangement.arrangeableInsets
@property (readwrite, assign, nonatomic) FLArrangeableGrowMode arrangeableGrowMode;
@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@end

@implementation FLArrangeableObjectState
+ (FLArrangeableObjectState*) arrangebleObjectState {
    return autorelease_([[[self class] alloc] init]);   
}

@synthesize arrangeableState = _arrangeableState;
@synthesize arrangeableInsets = _arrangeableInsets;
@synthesize arrangeableGrowMode = _arrangeableGrowMode;
@synthesize arrangeableWeight = _arrangeableWeight;
@end

/*
@property (readwrite, strong, nonatomic) FLArrangeableObjectState* arrangeableState;
- (FLArrangeableObjectState*) arrangeableStateObjectCreatedIfNeeded;
*/

@implementation NSObject (FLArrangeable)

FLSynthesizeAssociatedProperty(retain_nonatomic, arrangeableStateObject, setArrangeableStateObject, FLArrangeableObjectState*);

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

- (FLArrangeableGrowMode) arrangeableGrowMode {
    FLArrangeableObjectState* object = [self arrangeableStateObject];
    return object ? object.arrangeableGrowMode : FLArrangeableGrowModeNone;
}

- (void) setFrameFillBehavior:(FLArrangeableGrowMode) mask {
    FLArrangeableObjectState* object = [self arrangeableStateObjectCreatedIfNeeded];
    object.arrangeableGrowMode = mask;
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

+ (id) lastSubframeByWeight:(FLArrangeableWeight) weight
                  subframes:(NSArray*) subframes {
    
    id last = nil;
    for(id frame in subframes) {
        FLArrangeableWeight arrangeableWeight = [frame arrangeableWeight];
        if(arrangeableWeight > weight) {
            break;
        }
        
        last = frame;
    }
    
    return last;
}

@end
