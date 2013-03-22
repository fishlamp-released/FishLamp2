//
//  FLAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@implementation FLAnimation
@synthesize duration = _duration;
@synthesize animating = _animating;
@synthesize direction = _direction;
@synthesize timing = _timing;
@synthesize repeat = _repeat;
@synthesize axis = _axis;

- (id) init {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
    }
    return self;
}

- (void) prepare {
}

- (void) commit {
}

- (void) finish {
}

- (void) startAnimating:(FLAnimationCompletionBlock) completion {

    _animating = YES;

    completion = FLCopyWithAutorelease(completion);

    FLAssertWithComment([NSThread isMainThread], @"not on main thread");
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    [self prepare];
    
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction commit];

    [CATransaction setCompletionBlock:^{
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

        [self finish];
            
        [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
        [CATransaction commit];
        
        _animating = NO;

        if(_repeat) {
            [self startAnimating:completion];
        }
        else if(completion) {
            completion();
        }
    }];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setAnimationDuration:self.duration];
    [CATransaction setAnimationTimingFunction:self.timingFunction];
    
    [self commit];
   
    [CATransaction commit];
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
