//
//  FLAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"
#import "FLFinisher.h"

@implementation CALayer (FLAnimation)
- (CALayer*) layer {
    return self;
}
@end

@implementation FLAnimator 

+ (id) animator {
    return FLAutorelease([[[self class] alloc] init]);
}

@synthesize prepare = _prepare;
@synthesize commit = _commit;
@synthesize finish = _finish;

#if FL_MRC
- (void) dealloc {
    [_prepare release];
    [_commit release];
    [_finish release];
    [super dealloc];
}
#endif


@end

@interface FLAnimation ()
@property (readwrite, strong, nonatomic) id target;
@end

@implementation FLAnimation

@synthesize duration = _duration;
@synthesize timingFunction = _timingFunction;
@synthesize target = _target;

- (id) initWithTarget:(id) target {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
        self.target = target;
    }
    return self;
}

- (id) init {
    return [self initWithTarget:nil];
}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] initWithTarget:nil]);
}

+ (id) animationWithTarget:(id) target {
    return FLAutorelease([[[self class] alloc] initWithTarget:target]);
}

- (void) prepareAnimator:(FLAnimator*) animator  {
}

#if FL_MRC
- (void) dealloc {
    [_target release];
    [_timingFunction release];
    [_animations release];
    [super dealloc];
}
#endif

- (FLAnimator*) prepareAnimatorWithTarget:(id) target {
    FLAnimator* animator = [FLAnimator animator];
    [self prepareAnimator:animator];
    return animator;
}

- (NSArray*) openAnimation:(void (^)()) didStartBlock {
    
    FLAssert_v([NSThread isMainThread], @"not on main thread");
    
    id target = self.target;
    FLAnimator* firstAnimator = [self prepareAnimatorWithTarget:target];
    
    NSMutableArray* animators = nil;
    if(_animations && _animations.count) {
        animators = [NSMutableArray arrayWithCapacity:_animations.count + 1];
        [animators addObject:firstAnimator];

        for(FLAnimation* animation in _animations) {
            [animators addObject:[animation prepareAnimatorWithTarget:target]];
        }
    }
    else {
        animators = [NSArray arrayWithObject:firstAnimator];
    }
    
    for(FLAnimator* animator in animators) { 
        if(animator.prepare) {
            animator.prepare();
        }
    }

    [CATransaction begin];
    [CATransaction setAnimationDuration:self.duration];
    
    if(self.timingFunction) {
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:self.timingFunction]];
    }
    
    if(didStartBlock) {
        didStartBlock();
    }
    
    return animators;
}

- (void) closeAnimation:(NSArray*) animators 
             completion:(void (^)()) completion {

    FLSafeguardBlock(completion);

    [CATransaction setCompletionBlock:^{

        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];

        // finish in reverse order, so enclosing animations runs after enclosed animations for finishing.
        for(FLAnimator* animator in animators.reverseObjectEnumerator) {
            if(animator.finish) {
                animator.finish();
            }
        }
        
        [CATransaction commit];
        
        if(completion) {
            completion();
        }
    }];
    
    for(FLAnimator* animator in animators) {
        if(animator.commit) {
            animator.commit();
        }
    }
   
    [CATransaction commit];
}

- (void) startAnimating:(void (^)()) didStartBlock
             completion:(void (^)()) completion {
    [self closeAnimation:[self openAnimation:didStartBlock] completion:completion];
}   

//- (void) startWorking:(FLFinisher*) finisher {
//    [self closeAnimation:[self openAnimation:nil] completion:^{
//        [finisher setFinished];
//    }];
//}             
                
- (void) startAnimating:(void (^)()) completion {
    [self closeAnimation:[self openAnimation:nil] completion:completion];
}

- (void) startAnimating {
    [self closeAnimation:[self openAnimation:nil] completion:nil];
}

- (CALayer*) layer {
    FLAssertNotNil_(_target);
    FLAssertNotNil_([_target layer]);
    FLAssertNotNil_([_target layer].superlayer);
    return [_target layer];
}

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }

    [_animations addObject:animation];
}


@end

