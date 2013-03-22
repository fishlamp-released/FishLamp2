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

- (id) init {
    self = [super init];
    if(self) {
        _fromOpacity = -1;
        _toOpactity = -1;
    }
    return self;
}

@synthesize fromOpacity = _fromOpacity;
@synthesize toOpacity = _toOpacity;

- (void) setFadeToOpacity:(CGFloat) toOpacity fromOpacity:(CGFloat) fromOpacity {
    _fromOpacity = fromOpacity;
    _toOpacity = toOpacity;
}


- (void) commitAnimation:(CALayer*) layer {
    FLAssert(_fromOpacity >= 0.0);
    FLAssert(_toOpacity >= 0.0);

    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:layer.opacity];
    fade.toValue = [NSNumber numberWithFloat:_toOpacity];
    fade.removedOnCompletion = YES;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;

    [layer addAnimation:fade forKey:@"opacity"];
    [layer setOpacity:_toOpacity];
}

- (void) prepareAnimation:(CALayer*) layer {
    if(_fromOpacity < 0.0) {
        _fromOpacity = layer.opacity;
    }
    else {
        layer.opacity = _fromOpacity;
    }
    
    layer.hidden = NO;
}

- (void) finishAnimation:(CALayer*) layer{
    [layer setOpacity:_fromOpacity];
}

@end

@implementation FLFadeInAnimation

+ (id) fadeInAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareAnimation:(CALayer*) layer {
    layer.opacity = 0;
    layer.hidden = NO;
}

- (void) commitAnimation:(CALayer*) layer {

    CGFloat to = 1.0;
    CGFloat from = layer.opacity;

    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:from];
    fade.toValue = [NSNumber numberWithFloat:to];
    fade.removedOnCompletion = YES;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;
    [self configureAnimation:fade];
    
    [layer addAnimation:fade forKey:@"opacity"];
    [layer setOpacity:to];
}

- (void) finishAnimation:(CALayer*) layer {
    layer.opacity = 1.0;
    layer.hidden = NO;
}

@end



@implementation FLFadeOutAnimation

+ (id) fadeOutAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareAnimation:(CALayer*) layer {
}

- (void) commitAnimation:(CALayer*) layer {

    CGFloat to = 0.0;
    CGFloat from = layer.opacity;

    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:from];
    fade.toValue = [NSNumber numberWithFloat:to];
    fade.removedOnCompletion = YES;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;
    [self configureAnimation:fade];
    
    [layer addAnimation:fade forKey:@"opacity"];
    [layer setOpacity:to];
}

- (void) finishAnimation:(CALayer*) layer {
    layer.hidden = NO;
    layer.opacity = 1.0;
}


@end