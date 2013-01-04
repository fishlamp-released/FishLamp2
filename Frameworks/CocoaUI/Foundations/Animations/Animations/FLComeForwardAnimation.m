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

+ (CAAnimation) animationForLayer:(CALayer*) layer {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.removedOnCompletion = YES;
    return scale;
}

- (void) setTarget:(id) target {
    
    CALayer* layer = [self layerFromTarget:target];
    
    self.prepare = ^(id animation) {
        
        layer.transform = [FLDropBackAnimation transformForFrame:layer.frame withScale:_scale];
        layer.hidden = NO;
        
        CAAnimation* animation = [FLComeForwardAnimation animationForLayer:layer];
        
        self.commit = ^{
            [layer addAnimation:scale forKey:@"transform"];
            layer.transform =  CATransform3DIdentity;
        };
    };
}

@end
