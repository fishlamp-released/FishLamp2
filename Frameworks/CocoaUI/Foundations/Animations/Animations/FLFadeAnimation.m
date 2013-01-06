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

- (void) setTarget:(id) target 
       fromOpacity:(CGFloat) fromOpacity 
         toOpacity:(CGFloat) toOpacity {
    
    self.prepare = ^(id animation) {
        CALayer* layer = [animation layerFromTarget:target];
        layer.opacity = fromOpacity;
        layer.hidden = NO;
        [layer addAnimation:[FLFadeAnimation animationForLayer:layer fromOpacity:fromOpacity toOpacity:toOpacity] forKey:@"opacity"];
        
        self.commit = ^{
            [layer setOpacity:toOpacity];
        };
    };
}

@end

@implementation FLFadeInAnimation

- (void) setTarget:(id) target {
    [self setTarget:target fromOpacity:0.0 toOpacity:1.0];
}

@end

@implementation FLFadeOutAnimation

- (void) setTarget:(id) target {
    [self setTarget:target fromOpacity:1.0 toOpacity:0.0];
    CALayer* layer = [self layerFromTarget:target];

    self.finish = ^{
        layer.hidden = YES;
        [layer setOpacity:1.0];
    };
}

@end
