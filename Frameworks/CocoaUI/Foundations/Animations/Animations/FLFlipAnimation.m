//
//  FLFlipAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFlipAnimation.h"

@implementation FLFlipAnimation

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

+ (void) addPerspectiveToLayer:(CALayer*) layer 
       withPerspectiveDistance:(CGFloat) distance {
 
    if(distance > 0) {
        CATransform3D perspective = CATransform3DIdentity; 
        perspective.m34 = -1. / distance;
        layer.transform = perspective;
    }
}

+ (void) prepareLayerForFlip:(CALayer*) layer 
             inFlipDirection:(FLFlipAnimationDirection) flipDirection {

}

+ (CAAnimation*) createFlipAnimationForLayer:(CALayer*) layer 
                           withFlipDirection:(FLFlipAnimationDirection) flipDirection {
    
    CGFloat start = 0.0f;
    CGFloat finish = 0.0f;
    NSString* keyPath = nil;

    switch(flipDirection) {
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

- (void) setTarget:(id) target {

    CALayer* layer = [self layerFromTarget:target];

    layer.doubleSided = _showBothSidesDuringFlip;
    
    CGPoint position = layer.position;
    CGPoint newPosition = position;
    CGPoint anchorPoint = layer.anchorPoint;

    CGRect frame = layer.frame;
    newPosition.y += (frame.size.height/ 2);
    newPosition.x += (frame.size.width / 2);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.position = newPosition;
    
    CAAnimation* flipAnimation = [FLFlipAnimation createFlipAnimationForLayer:layer withFlipDirection:_flipDirection];

    self.prepare = ^(id animation){

//        [FLFlipAnimation addPerspectiveToLayer:layer withPerspectiveDistance:_perspectiveDistance];
    
        self.commit = ^{
            [layer addAnimation:flipAnimation forKey:@"flip"];    
        };

        self.finish = ^{
            layer.anchorPoint = anchorPoint;
            layer.position = position;
        
//            [self prepareLayerForFlip:FLFlipAnimationDirectionOpposite(_flipDirection)];
        };  

    };
}


@end
