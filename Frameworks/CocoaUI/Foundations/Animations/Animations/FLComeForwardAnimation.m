//
//  FLComeForwardAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLComeForwardAnimation.h"
#import "FLDropBackAnimation.h"

@implementation FLComeForwardAnimation

@synthesize scale = _scale;

+ (id) comeForwardAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

//- (id) initWithTarget:(id) target {
//    self = [super initWithTarget:target];

- (id) init {
    if(self) {
        _scale = FLDropBackAnimationDefaultScale;
    }
    return self;
}

- (CAAnimation*) CAAnimationForLayer:(CALayer*) layer {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.removedOnCompletion = YES;
    return scale;
}

- (void) prepareLayer:(CALayer*) layer {
    layer.transform = [FLDropBackAnimation transformForFrame:layer.frame withScale:_scale];
    layer.hidden = NO;
}

- (void) commitAnimation:(CALayer *)layer {
    CAAnimation* comeforward = [self CAAnimationForLayer:layer];
    [layer addAnimation:comeforward forKey:@"transform"];
    layer.transform =  CATransform3DIdentity;
}



@end
