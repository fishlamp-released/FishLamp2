//
//  FLAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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
@private
    CGFloat _duration;
    BOOL _repeat;
    BOOL _animating;
    NSMutableArray* _animations;
    
    FLAnimationAxis _animationAxis;
    FLAnimationDirection _animationDirection;
    FLAnimationTiming _animationTiming;
}

// these only apply to the animation upon which beginAnimation was called.
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, assign, nonatomic) BOOL repeat;
@property (readwrite, assign, nonatomic) FLAnimationDirection direction;
@property (readwrite, assign, nonatomic) FLAnimationAxis axis;
@property (readwrite, assign, nonatomic) FLAnimationTiming timing;
@property (readonly, assign, nonatomic, getter=isAnimating) BOOL animating;

+ (id) animation;

- (void) startAnimating:(id) target
             completion:(FLAnimationCompletionBlock) completion;

// use this to add child animations
- (void) addAnimation:(FLAnimation*) animation;

// overrides
// animations are disabled during prepare and finish,
// commit is where you apply the animations
- (void) prepareLayer:(CALayer*) layer;
- (void) commitAnimation:(CALayer*) layer;
- (void) finishAnimation:(CALayer*) layer;

- (void) stopAnimating;


// subclass utils
- (CAMediaTimingFunction*) timingFunction;
- (void) prepareAnimation:(CAAnimation*) animation;

@end

CAMediaTimingFunction* FLAnimationGetTimingFunction(FLAnimationTiming functionEnum);


