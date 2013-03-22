//
//  FLAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

typedef enum {
    FLAnimationDirectionRight,
    FLAnimationDirectionLeft,
    FLAnimationDirectionUp,
    FLAnimationDirectionDown,
} FLAnimationDirection;

NS_INLINE
FLAnimationDirection FLAnimationDirectionGetOppositeDirection(FLAnimationDirection direction) {
    switch(direction) {
        case FLAnimationDirectionUp: 
            return FLAnimationDirectionDown;
        case FLAnimationDirectionDown: 
            return FLAnimationDirectionUp;
        case FLAnimationDirectionLeft: 
            return FLAnimationDirectionRight;
        case FLAnimationDirectionRight: 
            return FLAnimationDirectionLeft;
    }
}

typedef enum {
    FLAnimationAxisX,
    FLAnimationAxisY,
    FLAnimationAxisZ
} FLAnimationAxis;

typedef enum {
    FLAnimationTimingDefault,
    FLAnimationTimingLinear,
    FLAnimationTimingEaseIn,
    FLAnimationTimingEaseOut,
    FLAnimationTimingEaseInEaseOut,
    FLAnimationTimingCustom   
} FLAnimationTiming;


@interface FLAnimation : NSObject {
    CGFloat _duration;
    BOOL _removeTransforms;
    FLAnimationTiming _animationTiming;
    FLAnimationDirection _animationDirection;
    FLAnimationAxis _animationAxis;
    BOOL _reverse;
}
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, assign, nonatomic) BOOL removeTransforms;
@property (readwrite, assign, nonatomic, getter=isReversed) BOOL reverse;

@property (readonly, assign, nonatomic) FLAnimationDirection directionWithPossibleReversing;

@property (readwrite, assign, nonatomic) FLAnimationTiming timing;
@property (readwrite, assign, nonatomic) FLAnimationDirection direction;
@property (readwrite, assign, nonatomic) FLAnimationAxis axis;

- (void) startAnimating:(FLBlock) prepare
                 commit:(FLBlock) commit
                 finish:(FLBlock) finish
             completion:(FLBlock) completion;
 
// subclass utils
- (CAMediaTimingFunction*) timingFunction;

- (void) prepareAnimation:(CAAnimation*) animation;

@end

CAMediaTimingFunction* FLAnimationGetTimingFunction(FLAnimationTiming functionEnum);
