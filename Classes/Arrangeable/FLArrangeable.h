//
//  FLArrangeableView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FishLampCocoa.h"
#import "FLArrangeable.h"
#import "FLRect.h"

// behavior

typedef enum {
    FLArrangeableFillModeNone,
	FLArrangeableFillModeFlexibleWidth,

    FLArrangeableFillModeGrowWidth,
    FLArrangeableFillModeGrowHeight,
} FLArrangeableFillMode;

// weight
enum {
    FLArrangeableWeightLight         = NSIntegerMin,
    FLArrangeableWeightNormal        = 0,
    FLArrangeableWeightHeavy         = NSIntegerMax
};
typedef NSInteger FLArrangeableWeight;

// internal state

typedef struct {
    FLEdgeInsets arrangeableInsets;
    FLArrangeableWeight arrangeableWeight;
    FLArrangeableFillMode arrangeableFillMode;

// this is for arrangements use only.
    FLRect _lastFrame;
    FLEdgeInsets _lastInsets;
} FLArrangeableState;

static const FLArrangeableState FLArrangeableStateZero;

@protocol FLArrangeable <NSObject>

@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets; // deltas from arrangement.arrangeableInsets

@property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode;

@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;

@property (readwrite, assign, nonatomic) FLRect frame;

// override point
- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode;

// for internal use by arrangement
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;
@end

@interface FLArrangeableObject : NSObject<FLArrangeable> {
@private
    FLArrangeableState _frameState;
    BOOL _hidden;
    CGRect _frame;
}

- (id) initWithFrame:(CGRect) frame;

+ (FLArrangeableObject*) arrangeableObject;

+ (FLArrangeableObject*) arrangeableObject:(CGRect) frame;

+ (id) lastSubframeByWeight:(FLArrangeableWeight) weight
                  subframes:(NSArray*) subframes;

@end
