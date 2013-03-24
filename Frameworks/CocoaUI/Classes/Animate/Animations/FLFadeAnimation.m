//
//  FLFadeAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFadeAnimation.h"

@interface FLOpacityAnimation ()
@property (readwrite, assign, nonatomic) CGFloat startOpacity;
@end

@implementation FLOpacityAnimation

@synthesize startOpacity = _startOpacity;

+ (id) fadeAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareAnimation:(CALayer*) layer {
    _startOpacity = layer.opacity;
}

- (void) finishAnimation:(CALayer*) layer{
    if(self.removeTransform) {
        [layer setOpacity:_startOpacity];
    }
}

- (void) commitFadeForLayer:(CALayer*) layer from:(CGFloat) fromOpacity toOpacity:(CGFloat) toOpacity {
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:fromOpacity];
    fade.toValue = [NSNumber numberWithFloat:toOpacity];
    [self configureAnimation:fade];
    [layer addAnimation:fade forKey:@"opacity"];
}

@end

@implementation FLFadeInAnimation

+ (id) fadeInAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareAnimation:(CALayer*) layer {
    [super prepareAnimation:layer];
    layer.opacity = 0;
    layer.hidden = NO;
}

- (void) commitAnimation:(CALayer*) layer {
    [self commitFadeForLayer:layer from:0.0 toOpacity:self.startOpacity];
}

- (void) finishAnimation:(CALayer*) layer {
    layer.opacity = self.startOpacity;
}

@end

@implementation FLFadeOutAnimation

+ (id) fadeOutAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) commitAnimation:(CALayer*) layer {
    [self commitFadeForLayer:layer from:self.startOpacity toOpacity:0];
}

- (void) finishAnimation:(CALayer*) layer {
    layer.hidden = YES;
    layer.opacity = self.startOpacity;
}


@end