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

@interface FLAnimation ()
@end

@implementation FLAnimation

@synthesize duration = _duration;
@synthesize repeat = _repeat;
@synthesize direction = _direction;
@synthesize axis = _axis;
@synthesize timing = _timing;
@synthesize animating = _animating;

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

#if FL_MRC
- (void) dealloc {
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


- (void) prepareAnimationsForLayer:(CALayer*) layer {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    [self prepareLayer:layer];
    for(FLAnimation* animation in _animations) {
        [animation prepareLayer:layer];
    }
    
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction commit];
}


- (void) finishAnimationsForLayer:(CALayer*) layer {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    // finish in reverse order, so enclosing animations runs after enclosed animations for finishing.
    if(_animations) {
        for(FLAnimation* animation in _animations.reverseObjectEnumerator) {
            [animation finishAnimation:layer];
        }
    }
    
    [self finishAnimation:layer];
    
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction commit];
    
    _animating = NO;
}

- (void) commitAnimationsForLayer:(CALayer*) layer {
    [self commitAnimation:layer];
    
    if(_animations) {
        for(FLAnimation* animation in _animations) {
            [animation commitAnimation:layer];
        }
    }
}

- (void) startAnimatingLayer:(CALayer*) layer 
                  completion:(FLAnimationCompletionBlock) completion {

    FLAssertWithComment([NSThread isMainThread], @"not on main thread");
    
    [self prepareAnimationsForLayer:layer];

    [CATransaction setCompletionBlock:^{
        [self finishAnimationsForLayer:layer];
        
        if(_repeat) {
            [self startAnimatingLayer:layer completion:completion];
        }
        else if(completion) {
            completion();
        }

    }];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setAnimationDuration:self.duration];
    [CATransaction setAnimationTimingFunction:self.timingFunction];
    
    [self commitAnimationsForLayer:layer];
   
    [CATransaction commit];
}

- (void) startAnimating:(id) target 
             completion:(FLAnimationCompletionBlock) completion {
    _animating = YES;

    CALayer* layer = [target layer];
    
    FLAssertNotNilWithComment(layer, @"layer is nil");
    
    FLAssertWithComment([NSThread isMainThread], @"not on main thread");
    completion = FLCopyWithAutorelease(completion);

    [self startAnimatingLayer:layer completion:completion];
}

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }

    [_animations addObject:animation];
}

- (void) stopAnimating {
    _repeat = NO;
}

- (CAMediaTimingFunction*) timingFunction {
    return FLAnimationGetTimingFunction(self.timing);
}

- (void) prepareAnimation:(CAAnimation*) animation {
    [animation setDuration:self.duration];
    [animation setTimingFunction:self.timingFunction];
}

@end

CAMediaTimingFunction* FLAnimationGetTimingFunction(FLAnimationTiming functionEnum) {
    switch(functionEnum) {
        case FLAnimationTimingDefault:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        break;
        case FLAnimationTimingLinear:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        break;
        case FLAnimationTimingEaseIn:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        break;
        case FLAnimationTimingEaseOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        break;
        case FLAnimationTimingEaseInEaseOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        break;
        case FLAnimationTimingCustom:   
            return nil;
        break;
    }
    
    return nil;
}

