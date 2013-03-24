//
//  FLAbstractAnimation.h
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

#define FLAnimationDirectionForward     FLAnimationDirectionRight
#define FLAnimationDirectionBackward    FLAnimationDirectionLeft

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

@interface FLAbstractAnimation : NSObject {
@private
    CGFloat _duration;
    BOOL _removeTransform;
    FLAnimationTiming _timing;
    FLAnimationDirection _direction;
    FLAnimationAxis _axis;
    __unsafe_unretained FLAbstractAnimation* _parentAnimation;
}

@property (readwrite, assign, nonatomic) BOOL removeTransform;
@property (readwrite, assign, nonatomic) FLAbstractAnimation* parentAnimation;

@property (readwrite, assign, nonatomic) CGFloat duration;

@property (readwrite, assign, nonatomic) FLAnimationTiming timing;
@property (readwrite, assign, nonatomic) FLAnimationDirection direction;
@property (readwrite, assign, nonatomic) FLAnimationAxis axis;

- (void) startAnimationWithPrepareBlock:(FLBlock) prepare
                          commitBlock:(FLBlock) commit
                          finishBlock:(FLBlock) finish
                      completionBlock:(FLBlock) completion;
 
// subclass utils
- (CAMediaTimingFunction*) timingFunction;

- (void) configureAnimation:(CAAnimation*) animation;

@end

CAMediaTimingFunction* FLAnimationGetTimingFunction(FLAnimationTiming functionEnum);