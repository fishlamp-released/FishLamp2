//
//  FLAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@implementation CALayer (FLAnimation)
- (CALayer*) layer {
    return self;
}
@end

@interface FLAnimation ()
@end

@implementation FLAnimation

@synthesize prepare = _prepare;
@synthesize commit = _commit;
@synthesize finish = _finish;
@synthesize duration = _duration;
@synthesize timingFunction = _timingFunction;

- (id) init {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
    }
    return self;
}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) animationWithTarget:(id) target {
    FLAnimation* animation = FLAutorelease([[[self class] alloc] init]);
    if(target) {
        [animation setTarget:target];
    }
    
    return animation;
}

- (void) setTarget:(id) target {
}

#if FL_MRC
- (void) dealloc {
    [_timingFunction release];
    [_prepare release];
    [_commit release];
    [_finish release];
    [_animations release];
    [super dealloc];
}
#endif

- (void) openAnimation {

    if(self.prepare) {
        self.prepare(self);
    }

    for(FLAnimation* animation in _animations) {
        if(animation.prepare) {
            animation.prepare(animation);
        }
    }

    [CATransaction begin];
    [CATransaction setAnimationDuration:self.duration];
    
    if(self.timingFunction) {
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:self.timingFunction]];
    }
}

- (void) closeAnimation:(void (^)()) completion {
    FLSafeguardBlock(completion);

    [CATransaction setCompletionBlock:^{

        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];

        for(FLAnimation* animation in _animations) {
            if(animation.finish) {
                animation.finish();
            }
        }
   
        if(self.finish) {
            self.finish();
        }
        
        [CATransaction commit];
        
        if(completion) {
            completion();
        }
    }];

    
    for(FLAnimation* animation in _animations) {
        if(animation.commit) {
            animation.commit();
        }
    }

    if(self.commit) {
        self.commit();
    }    
    
    [CATransaction commit];
}

- (void) startAnimating:(void (^)()) didStartBlock
             completion:(void (^)()) completion {

    [self openAnimation];
    if(didStartBlock) {
        didStartBlock();
    }
    [self closeAnimation:completion];
}   

- (void) startWorking:(FLFinisher*) finisher {
    [self openAnimation];
    [self closeAnimation:^{
        [finisher setFinished];
    }];
}             
                
- (void) startAnimating:(void (^)()) completion {
    [self startAnimating:nil completion:completion];
}

- (void) startAnimating {
    [self startAnimating:nil completion:nil];
}

- (CALayer*) layerFromTarget:(id) target {
    FLAssertNotNil_(target);
    FLAssertNotNil_([target layer]);
    FLAssertNotNil_([target layer].superlayer);
    return [target layer];
}

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }

    [_animations addObject:animation];
}


@end

