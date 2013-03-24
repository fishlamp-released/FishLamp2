//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLViewTransition.h"
#import "FLFlipAnimation.h"

#define FLFlipTransitionDefaultPerspectiveDistance 1500.0f

@interface FLFlipTransition : FLViewTransition {
@private
    FLAnimationDirection _flipDirection;
    CGFloat _perspectiveDistance;
    CGFloat _scale;
}

+ (id) flipTransition:(FLAnimationDirection) animationDirection;

@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipTransitionDefaultPerspectiveDistance
@property (readwrite, assign, nonatomic) CGFloat perspectiveScale;

@end

