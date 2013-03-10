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

//@implementation FLAnimator  {
//@private
//    FLAnimationBlock _prepare;
//    FLAnimationBlock _commit;
//    FLAnimationBlock _finish;
//}
//
//+ (id) animation {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//@synthesize prepare = _prepare;
//@synthesize commit = _commit;
//@synthesize finish = _finish;
//
//#if FL_MRC
//- (void) dealloc {
//    [_prepare release];
//    [_commit release];
//    [_finish release];
//    [super dealloc];
//}
//#endif
//
//
//@end

@interface FLAnimation ()
//@property (readwrite, strong, nonatomic) id target;
@end

@implementation FLAnimation  {
@private
    CGFloat _duration;
    NSString* _timingFunction;
    NSMutableArray* _animations;
}

@synthesize duration = _duration;
@synthesize timingFunction = _timingFunction;

- (id) init {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
    }
    return self;
}

//- (id) init {
//    return [self initWithTarget:nil];
//}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] init]);
}

//+ (id) animationWithTarget:(id) target {
//    return FLAutorelease([[[self class] alloc] initWithTarget:target]);
//}

#if FL_MRC
- (void) dealloc {
    [_timingFunction release];
    [_animations release];
    [super dealloc];
}
#endif

- (void) prepareLayer:(CALayer*) layer {
}

- (void) commitAnimation:(CALayer*) layer {
}

- (void) finishAnimation:(CALayer*) layer {
}


- (void) openAnimation:(CALayer*) layer
         didStartBlock:(void (^)()) didStartBlock {
    
    FLAssertNotNil_v(layer, @"layer is nil");
    
    FLAssert_v([NSThread isMainThread], @"not on main thread");
    
    [self prepareLayer:layer];
    for(FLAnimation* animation in _animations) {
        [animation prepareLayer:layer];
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:self.duration];
    
    if(self.timingFunction) {
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:self.timingFunction]];
    }
    
    if(didStartBlock) {
        didStartBlock();
    }
}

- (void) closeAnimation:(CALayer*) layer
             completion:(void (^)()) completion {

    FLSafeguardBlock(completion);

    [CATransaction setCompletionBlock:^{

        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];

        // finish in reverse order, so enclosing animations runs after enclosed animations for finishing.
        if(_animations) {
            for(FLAnimation* animation in _animations.reverseObjectEnumerator) {
                [animation finishAnimation:layer];
            }
        }
        
        [self finishAnimation:layer];
        
        [CATransaction commit];
        
        if(completion) {
            completion();
        }
    }];

    [self commitAnimation:layer];
    
    if(_animations) {
        for(FLAnimation* animation in _animations) {
            [animation commitAnimation:layer];
        }
    }
   
    [CATransaction commit];
}

- (void) startAnimating:(id) target
          didStartBlock:(void (^)()) didStartBlock
             completion:(void (^)()) completion {

    CALayer* layer = [target layer];
             
    [self openAnimation:layer didStartBlock:didStartBlock]; 

    [self closeAnimation:layer completion:completion];
}             
                
- (void) startAnimating:(id) target 
             completion:(void (^)()) completion {
    [self startAnimating:target didStartBlock:nil completion:completion];
}

- (void) startAnimating:(id) target {
    [self startAnimating:target didStartBlock:nil completion:nil];
}

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }

    [_animations addObject:animation];
}


@end

