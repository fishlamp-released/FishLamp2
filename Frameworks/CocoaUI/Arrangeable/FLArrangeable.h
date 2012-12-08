//
//  FLArrangeableView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCore.h"
#import "FLArrangeable.h"

// behavior
//
//typedef short FLPaddingInt;
//
//typedef struct {
//    FLPaddingInt left;
//    FLPaddingInt right;
//    FLPaddingInt top;
//    FLPaddingInt bottom;
//} FLArrangeablePadding;

typedef FLEdgeInsets FLPaddingInsets;

#define FLPaddingInsetsZero SDKEdgeInsetsZero
#define FLPaddingInsetsMake FLEdgeInsetsMake

typedef enum {
    FLArrangeableGrowModeNone,
	FLArrangeableGrowModeFlexibleWidth,

    FLArrangeableGrowModeGrowWidth,
    FLArrangeableGrowModeGrowHeight,
} FLArrangeableGrowMode;

// weight
#define FLArrangeableWeightLight         −128
#define FLArrangeableWeightNormal        0
#define FLArrangeableWeightHeavy         127

typedef int8_t FLArrangeableWeight;

// internal state

//    SDKEdgeInsets arrangeableInsets;
//    FLArrangeableWeight arrangeableWeight;
//    FLArrangeableGrowMode arrangeableGrowMode;

// this is for arrangements use only.
typedef struct {
    CGRect _lastFrame;
    FLPaddingInsets _lastInsets;
} FLArrangeableState;

static const FLArrangeableState FLArrangeableStateZero;

@protocol FLArrangeable <NSObject>

@property (readwrite, assign, nonatomic) FLPaddingInsets arrangeableInsets;

@property (readwrite, assign, nonatomic) FLArrangeableGrowMode arrangeableGrowMode;

@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;

@property (readwrite, assign, nonatomic) CGRect arrangeableFrame;

// override point
- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableGrowMode) fillMode;

// for internal use by arrangement
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;
@end



//typedef struct {
//    FLArrangeablePadding_t padding;
//    FLArrangeablePadding_t last;
//    unsigned int flags: 24;
//    int weight: 8;
//    
//} FLArrangeableState_t;

