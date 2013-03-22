//
//  FLAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

typedef enum {
    FLAnimationDirectionForward,
    FLAnimationDirectionBackward,
} FLAnimationDirection;


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

typedef void (^FLAnimationCompletionBlock)();

@interface FLAnimation : NSObject {
    CGFloat _duration;
    BOOL _animating;
    BOOL _repeat;
    FLAnimationTiming _animationTiming;
    FLAnimationDirection _animationDirection;
    FLAnimationAxis _animationAxis;
}
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readonly, assign, nonatomic, getter=isAnimating) BOOL animating;
@property (readwrite, assign, nonatomic) FLAnimationTiming timing;
@property (readwrite, assign, nonatomic) FLAnimationDirection direction;
@property (readwrite, assign, nonatomic) BOOL repeat;
@property (readwrite, assign, nonatomic) FLAnimationAxis axis;

- (void) prepare;
- (void) commit;
- (void) finish;

- (void) startAnimating:(FLAnimationCompletionBlock) completion;
 
// subclass utils
- (CAMediaTimingFunction*) timingFunction;

- (void) prepareAnimation:(CAAnimation*) animation;

@end

CAMediaTimingFunction* FLAnimationGetTimingFunction(FLAnimationTiming functionEnum);
