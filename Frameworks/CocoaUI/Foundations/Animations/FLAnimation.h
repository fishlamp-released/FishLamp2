//
//  FLAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@class FLAnimation;

typedef void (^FLAnimationPrepareBlock)(id animation);
typedef void (^FLAnimationBlock)();

@interface FLAnimator : NSObject {
    FLAnimationBlock _prepare;
    FLAnimationBlock _commit;
    FLAnimationBlock _finish;
}
@property (readwrite, copy, nonatomic) FLAnimationBlock prepare;
@property (readwrite, copy, nonatomic) FLAnimationBlock commit;
@property (readwrite, copy, nonatomic) FLAnimationBlock finish;
@end

@interface FLAnimation : NSObject {
@private
    CGFloat _duration;
    NSString* _timingFunction;
    NSMutableArray* _animations;
    id _target;
}

@property (readonly, strong, nonatomic) id target;
@property (readonly, strong, nonatomic) CALayer* layer; 

// these only apply to the animation upon which beginAnimation was called.
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, strong, nonatomic) NSString* timingFunction;

- (id) initWithTarget:(id) target;

+ (id) animation;
+ (id) animationWithTarget:(id) target;

// to animated call one of these
- (void) startAnimating;

- (void) startAnimating:(void (^)()) completion;

- (void) startAnimating:(void (^)()) didStartBlock
             completion:(void (^)()) completion;

// override this and set the blocks in the animator
- (void) prepareAnimator:(FLAnimator*) animator;

// use this to add child animations
- (void) addAnimation:(FLAnimation*) animation;

@end


