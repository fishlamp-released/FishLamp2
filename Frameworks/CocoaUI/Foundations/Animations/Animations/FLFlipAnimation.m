//
//  FLFlipAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFlipAnimation.h"

@implementation FLFlipAnimation {
@private
    FLFlipAnimationDirection _flipDirection;
    BOOL _showBothSidesDuringFlip;
    CGFloat _perspectiveDistance;
    CGPoint _position;
    CGPoint _anchorPoint;
}

@synthesize flipDirection = _flipDirection;
@synthesize showBothSidesDuringFlip = _showBothSidesDuringFlip;
@synthesize perspectiveDistance = _perspectiveDistance;

- (id) init {
    self = [super init];
    if(self) {
        _perspectiveDistance = FLFlipAnimationDefaultPerspectiveDistance;
        _showBothSidesDuringFlip = YES;
    }
    return self;
}

- (id) initWithFlipDirection:(FLFlipAnimationDirection) direction {
    self = [self init];
    if(self) {
        _flipDirection = direction;
    }
    return self;
}

+ (id) flipAnimation:(FLFlipAnimationDirection) direction {
    return FLAutorelease([[[self class] alloc] initWithFlipDirection:direction]);
}

+ (void) addPerspectiveToLayer:(CALayer*) layer 
       withPerspectiveDistance:(CGFloat) distance {
 
    if(distance > 0) {
        CATransform3D perspective = CATransform3DIdentity; 
        perspective.m34 = -1. / distance;
        layer.transform = perspective;
    }
}

- (CAAnimation*) CAAnimation {
    
    CGFloat start = 0.0f;
    CGFloat finish = 0.0f;
    NSString* keyPath = nil;

    switch(_flipDirection) {
        case FLFlipAnimationDirectionUp:
            keyPath = @"transform.rotation.x";
            start = M_PI;
            finish = 0.0;
        break;
        
        case FLFlipAnimationDirectionDown:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = -M_PI;
        break;

        case FLFlipAnimationDirectionLeft:
            keyPath = @"transform.rotation.y";
            start = M_PI;
            finish = 0.0f;
        break;

        case FLFlipAnimationDirectionRight:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = -M_PI;
        break;
    }

    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    flipAnimation.fromValue = [NSNumber numberWithDouble:start];
    flipAnimation.toValue = [NSNumber numberWithDouble:finish];
    flipAnimation.fillMode = kCAFillModeBoth;
    flipAnimation.additive = NO;
    flipAnimation.removedOnCompletion = NO;
    return flipAnimation;

}


- (void) prepareLayer:(CALayer*) layer {
    layer.doubleSided = _showBothSidesDuringFlip;
    
    _position = layer.position;
    _anchorPoint = layer.anchorPoint;

    CGRect frame = layer.frame;
    CGPoint newPosition = _position;
    newPosition.y += (frame.size.height/ 2);
    newPosition.x += (frame.size.width / 2);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.position = newPosition;
}

- (void) commitAnimation:(CALayer*) layer {
    [layer addAnimation:[self CAAnimation] forKey:@"flip"];    
}

- (void) finishAnimation:(CALayer*) layer {
    layer.anchorPoint = _anchorPoint;
    layer.position = _position;
}



@end
