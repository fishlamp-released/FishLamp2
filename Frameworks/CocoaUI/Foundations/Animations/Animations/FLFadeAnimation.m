//
//  FLFadeAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFadeAnimation.h"

@implementation FLFadeAnimation

+ (id) fadeAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (CAAnimation*) animationForLayer:(CALayer*) layer 
                         fromOpacity:(CGFloat) fromOpacity 
                           toOpacity:(CGFloat) toOpacity {
 
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:fromOpacity];
    fade.toValue = [NSNumber numberWithFloat:toOpacity];
    fade.removedOnCompletion = NO;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;
    return fade;                      
}                           

- (void) prepareAnimator:(FLAnimator*) animator 
             fromOpacity:(CGFloat) fromOpacity 
               toOpacity:(CGFloat) toOpacity {
    
    CALayer* layer = self.layer;
    layer.opacity = fromOpacity;
    layer.hidden = NO;

    animator.commit = ^{
        [layer addAnimation:[FLFadeAnimation animationForLayer:layer fromOpacity:fromOpacity toOpacity:toOpacity] forKey:@"opacity"];
        [layer setOpacity:toOpacity];
    };

}

@end

@implementation FLFadeInAnimation

- (void) prepareAnimator:(FLAnimator*) animator {
    [self prepareAnimator:animator fromOpacity:0.0 toOpacity:1.0];
}

@end

@implementation FLFadeOutAnimation

- (void) prepareAnimator:(FLAnimator*) animator {

    [self prepareAnimator:animator fromOpacity:1.0 toOpacity:0.0];

    CALayer* layer = self.layer;
    animator.finish = ^{
        layer.hidden = YES;
        [layer setOpacity:1.0];
    };
}

@end
