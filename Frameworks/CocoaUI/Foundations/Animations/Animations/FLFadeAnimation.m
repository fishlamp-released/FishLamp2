//
//  FLFadeAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFadeAnimation.h"

@implementation FLFadeAnimation {
@private
    CGFloat _fromOpacity;
    CGFloat _toOpactity;
}

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

- (CAAnimation*) CAAnimation {
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:_fromOpacity];
    fade.toValue = [NSNumber numberWithFloat:_toOpacity];
    fade.removedOnCompletion = NO;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;
    return fade;                      
}                           

- (void) commitAnimation:(CALayer*) layer {
    FLAssert(_fromOpacity >= 0.0);
    FLAssert(_toOpacity >= 0.0);

    [layer addAnimation:[self CAAnimation] forKey:@"opacity"];
    [layer setOpacity:_toOpacity];
}

- (void) prepareLayer:(CALayer*) layer {
    if(_fromOpacity < 0.0) {
        _fromOpacity = layer.opacity;
    }
    else {
        layer.opacity = _fromOpacity;
    }
    
    layer.hidden = NO;
}

- (void) finishAnimation:(CALayer*) layer {
    [layer setOpacity:_fromOpacity];
}

@end

@implementation FLFadeInAnimation

+ (id) fadeInAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareLayer:(CALayer*) layer {
    [super prepareLayer:layer];
    
    if(self.isReversed) {
        if(self.toOpacity < 0) {
            self.toOpacity = 0.0f;
        }
    }
    else {
        if(self.toOpacity < 0) {
            self.toOpacity = 1.0f;
        }
    }
}

- (void) finishAnimation:(CALayer*) layer {
    layer.hidden = self.isReversed;
    [super finishAnimation:layer];
}


@end


