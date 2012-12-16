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

@interface UIView (FLAnimation)
- (UIView*) view; // returns self.
@end

@interface FLAnimation : NSObject {
@private
    FLAnimationBlock _prepare;
    FLAnimationBlock _commit;
    FLAnimationBlock _finish;
    CGFloat _duration;
    
    id _parent;
    id _target;
    id _sibling;
    
    NSMutableArray* _animations;
    
    __unsafe_unretained FLAnimation* _parentAnimation;
}

+ (id) animation;
+ (id) animationWithDuration:(CGFloat) duration;
+ (id) animationWithTarget:(id) target;

- (id) addAnimation:(FLAnimation*) animation;
@property (readonly, assign, nonatomic) FLAnimation* parentAnimation;

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

- (void) startAnimating:(dispatch_block_t) completion;

@end
