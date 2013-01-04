//
//  FLDropBackAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDropBackAnimation.h"

@implementation FLDropBackAnimation

@synthesize scale = _scale;

- (id) init {
    self = [super init];
    if(self) {
        _scale = FLDropBackAnimationDefaultScale;
    }
    return self;
}

+ (CATransform3D) transformForFrame:(CGRect) frame 
                          withScale:(CGFloat) scaleAmount {

    CATransform3D scaleTransform = CATransform3DMakeScale(scaleAmount, scaleAmount, 1);
    CATransform3D translateTransform = CATransform3DMakeTranslation((frame.size.width * (1.0 - scaleAmount)) / 2.0f,  
                                                                    (frame.size.height * (1.0 - scaleAmount)), 0);

    return CATransform3DConcat(translateTransform, scaleTransform);

} 

+ (CAAnimation*) animationForLayer:(CALayer *) layer withScale:(CGFloat) scaleAmount {
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:transform];
    scale.removedOnCompletion = YES;
    return scale;
}

- (void) setTarget:(id) target {
    
    self.prepare = ^(id animation) {
        CALayer* layer = [self layerFromTarget:target]; {    
        layer.transform = CATransform3DIdentity;
        layer.hidden = NO;
        
        CATransform3D transform = [FLDropBackAnimation transformForFrame:layer.frame withScale:_scale];
        CAAnimation* dropBack = [FLDropBackAnimation animationForLayer:layer withScale:_scale];

        self.commit = ^{
            [layer addAnimation:dropBack forKey:@"transform"];
            layer.transform = transform;
        };

        self.finish = ^{
            layer.hidden = YES;
            layer.transform = CATransform3DIdentity;
        };
    };
}

@end

