//
//  FLDropBackAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDropBackAnimation.h"

@implementation FLDropBackAnimation {
@private
    CGFloat _scale;
}

@synthesize scale = _scale;

- (id) init {
    self = [super init];
    if(self) {
        _scale = FLDropBackAnimationDefaultScale;
    }
    return self;
}

+ (id) dropBackAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (CATransform3D) transformForFrame:(CGRect) frame 
                          withScale:(CGFloat) scaleAmount {

    CATransform3D scaleTransform = CATransform3DMakeScale(scaleAmount, scaleAmount, 1);
    CATransform3D translateTransform = CATransform3DMakeTranslation((frame.size.width * (1.0 - scaleAmount)) / 2.0f,  
                                                                    (frame.size.height * (1.0 - scaleAmount)), 0);

    return CATransform3DConcat(translateTransform, scaleTransform);

} 


- (void) prepareLayer:(CALayer*) layer {
    layer.transform = CATransform3DIdentity;
    layer.hidden = NO;
}

- (void) commitAnimation:(CALayer*) layer {
    CATransform3D transform = [FLDropBackAnimation transformForFrame:layer.frame withScale:_scale];

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:transform];
    scale.removedOnCompletion = YES;

    [layer addAnimation:scale forKey:@"transform"];
    layer.transform = transform;
}

- (void) finishAnimation:(CALayer*) layer {
    layer.hidden = YES;
    layer.transform = CATransform3DIdentity;
}

@end

