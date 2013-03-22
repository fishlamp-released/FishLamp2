//
//  FLComeForwardAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDistanceAnimation.h"

@implementation FLDistanceAnimation 

@synthesize scale = _scale;

- (id) init {
    self = [super init];
    if(self) {
        _scale = FLDropBackAnimationDefaultScale;
    }
    return self;
}

+ (id) distanceAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (CATransform3D) transformForFrame:(CGRect) frame withScale:(CGFloat) scaleAmount {

    CATransform3D scaleTransform = CATransform3DMakeScale(scaleAmount, scaleAmount, 1);
    CATransform3D translateTransform = CATransform3DMakeTranslation((frame.size.width * (1.0 - scaleAmount)) / 2.0f,  
                                                                    (frame.size.height * (1.0 - scaleAmount)), 0);

    return CATransform3DConcat(translateTransform, scaleTransform);
} 

- (void) prepareLayer:(CALayer*) layer {

    _startFrame = layer.frame;

    if(self.direction == FLAnimationDirectionRight) {
        _start = [self transformForFrame:layer.frame withScale:_scale];
        _finish = CATransform3DIdentity;
    }
    else {
        _start = CATransform3DIdentity;
        _finish = [self transformForFrame:layer.frame withScale:_scale];
    }

    layer.transform = _start;
    layer.hidden = NO;
}

- (void) commitAnimation:(CALayer *)layer {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:_start];
    scale.toValue =     [NSValue valueWithCATransform3D:_finish];
    scale.removedOnCompletion = YES;
    [self prepareAnimation:scale];

    [layer addAnimation:scale forKey:@"transform"];
}

- (void) finishAnimation:(CALayer*) layer {
    layer.frame = _startFrame;
    if(self.removeTransforms) {
        layer.transform = CATransform3DIdentity;
    }
}

@end

