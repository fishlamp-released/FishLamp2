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

- (id) init {
    self = [super init];
    if(self) {
        _duration = 0.3f;
    }
    return self;
}

- (id) initWithDuration:(CGFloat) duration {
    self = [super init];
    if(self) {
        _duration = duration;
    }
    return self;
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

- (id) initWithTarget:(id) target {
    self = [super init];
    if(self) {
        self.target = target;
    }
    return self;
}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) animationWithDuration:(CGFloat) duration {
    return FLAutorelease([[[self class] alloc] initWithDuration:duration]);
}

+ (id) animationWithTarget:(id) target {
    return FLAutorelease([[[self class] alloc] initWithTarget:target]);
}

- (id) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }
    
    animation.parentAnimation = self;
    [_animations addObject:animation];
    
    return animation;
}

#if FL_MRC
- (void) dealloc {
    [_target release];
    [_sibling release];
    [_parent release];
    [_animations release];
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
        
    for(FLAnimation* anim in _animations) {
        [anim prepare];
    }
}

- (void) commit {
    if(_commit) {
        _commit(self);
    }
        
    for(FLAnimation* anim in _animations) {
        [anim commit];
    }
}

- (void) finish {
    if(_finish) {
        _finish(self);
    }
        
    for(FLAnimation* anim in _animations) {
        [anim finish];
    }
}

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

@end
