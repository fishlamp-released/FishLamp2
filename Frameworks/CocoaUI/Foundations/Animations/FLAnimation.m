//
//  FLAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"



@interface FLAnimation ()
@property (readwrite, assign, nonatomic) FLAnimation* parentAnimation;
@end

@implementation UIView (FLAnimation)
- (UIView*) view {
    return self;
}
@end

@implementation FLAnimation

@synthesize prepareBlock = _prepare;
@synthesize commitBlock = _commit;
@synthesize finishBlock = _finish;
@synthesize parent = _parent;
@synthesize target = _target;
@synthesize sibling = _sibling;
@synthesize parentAnimation = _parentAnimation;
@synthesize options = _options;

- (id) initWithTarget:(id) target {
    return [self initWithTarget:target options:0];
}

- (id) initWithTarget:(id) target options:(FLAnimationOptions) options {
    self = [super init];
    if(self) {
        self.target = target;
        self.options = options;
    }
    return self;
}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] initWithTarget:nil options:0]);
}

+ (id) animation:(id) target {
    return FLAutorelease([[[self class] alloc] initWithTarget:target options:0]);
}

+ (id) animation:(id) target options:(FLAnimationOptions) options {
    return FLAutorelease([[[self class] alloc] initWithTarget:target options:options]);
}

- (UIView*) targetView {
    return [_target view];
}

- (UIView*) siblingView {
    return [_sibling view];
}

- (UIView*) superview {
    return [_parent view];
}
#if FL_MRC
- (void) dealloc {
    [_target release];
    [_sibling release];
    [_parent release];
    [_prepare release];
    [_commit release];
    [_finish release];
    [super dealloc];
}
#endif

- (void) prepare {
    if(_prepare) {
        _prepare(self);
    }
}

- (void) commit {
    if(_commit) {
        _commit(self);
    }
}

- (void) finish {
    if(_finish) {
        _finish(self);
    }
    
    if(FLTestBits(self.options, FLAnimationOptionRemoveTargetViewFromSuperview)) {
        [self removeTargetViewFromSuperview];
    }
    
    if(FLTestBits(self.options, FLAnimationOptionRestoreValues)) {
        [self restoreValues];
    }
}

- (void) restoreValues {
}

- (void) removeTargetViewFromSuperview {
    [self.targetView removeFromSuperview];
}


@end

@implementation FLAnimator 

- (void) startAnimating:(dispatch_block_t) completion {
    
    [self prepare];
    
    completion = FLAutoreleasedCopy(completion);
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_duration];
    
    [CATransaction setCompletionBlock:^{
        [self finish];
        
        if(completion) {
            completion();
        }
    }];
    
    [self commit];
    
    [CATransaction commit];
}

#if FL_MRC
- (void) dealloc {
    [_animations release];
    [super dealloc];
}
#endif

+ (id) animator {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) animator:(CGFloat) duration {
    return FLAutorelease([[[self class] alloc] initWithDuration:duration]);
}

//+ (id) animationWithTarget:(id) target {
//    return FLAutorelease([[[self class] alloc] initWithTarget:target]);
//}

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }
    
    animation.parentAnimation = self;
    [_animations addObject:animation];
}

- (void) addAnimation:(FLAnimation*) animation 
          configure:(void (^)(FLAnimation*)) configureBlock {
 
    if(configureBlock) {
        configureBlock(animation);
    }
    
    [self addAnimation:animation];
}

- (id) init {
    return [self initWithDuration:0.3f];
}

- (id) initWithDuration:(CGFloat) duration {
    self = [super init];
    if(self) {
        _duration = duration;
    }
    return self;
}

- (void) prepare {
    [super prepare];  
    
    for(FLAnimation* anim in _animations) {
        [anim prepare];
    }
}

- (void) commit {
    [super commit];  
    
    for(FLAnimation* anim in _animations) {
        [anim commit];
    }
}

- (void) finish {
    [super finish];
        
    for(FLAnimation* anim in _animations) {
        [anim finish];
    }
}


@end
