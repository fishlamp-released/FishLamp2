//
//  FLAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@class FLAnimation;

typedef void (^FLAnimationBlock)(FLAnimation* animation);

enum {
    FLAnimationOptionNone                             = 0,
    FLAnimationOptionRemoveTargetViewFromSuperview    = (1 << 1),
    FLAnimationOptionRestoreValues                    = (1 << 2)
}; 

typedef NSUInteger FLAnimationOptions;

@interface UIView (FLAnimation)
- (UIView*) view; // returns self.
@end

@interface FLAnimation : NSObject {
@private
    FLAnimationBlock _prepare;
    FLAnimationBlock _commit;
    FLAnimationBlock _finish;
    id _parent;
    id _target;
    id _sibling;
    FLAnimationOptions _options;
    __unsafe_unretained FLAnimation* _parentAnimation;
}

- (id) initWithTarget:(id) target;
- (id) initWithTarget:(id) target options:(FLAnimationOptions) options;

+ (id) animation;
+ (id) animation:(id) target;
+ (id) animation:(id) target options:(FLAnimationOptions) options;

@property (readonly, assign, nonatomic) FLAnimation* parentAnimation;

@property (readwrite, assign, nonatomic) FLAnimationOptions options;
@property (readwrite, strong, nonatomic) id parent;
@property (readwrite, strong, nonatomic) id sibling;
@property (readwrite, strong, nonatomic) id target;

@property (readonly, strong, nonatomic) UIView* targetView;
@property (readonly, strong, nonatomic) UIView* siblingView;
@property (readonly, strong, nonatomic) UIView* superview;

@property (readwrite, copy, nonatomic) FLAnimationBlock prepareBlock;
@property (readwrite, copy, nonatomic) FLAnimationBlock commitBlock;
@property (readwrite, copy, nonatomic) FLAnimationBlock finishBlock;

- (void) prepare;
- (void) commit;
- (void) finish;

- (void) restoreValues;
- (void) removeTargetViewFromSuperview;

@end

@interface FLAnimator : FLAnimation {
    CGFloat _duration;
    NSMutableArray* _animations;
}

+ (id) animator;
+ (id) animator:(CGFloat) duration;

- (void) addAnimation:(FLAnimation*) animation;

- (void) addAnimation:(FLAnimation*) animation 
            configure:(void (^)(FLAnimation*)) configureBlock;

- (void) startAnimating:(dispatch_block_t) completion;

@end