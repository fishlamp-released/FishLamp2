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
             inFlipDirection:(FLFlipViewAnimatorDirection) flipDirection {
        
    CGRect newFrame = layer.frame;
    
     switch(flipDirection) {
        case FLFlipViewAnimatorDirectionUp:
            newFrame.origin.y = newFrame.size.height / 2;
            layer.anchorPoint = CGPointMake(0, .5);
        break;
        
        case FLFlipViewAnimatorDirectionDown:
            newFrame.origin.y = newFrame.size.height / 2;
            layer.anchorPoint = CGPointMake(0, .5);
        break;

        case FLFlipViewAnimatorDirectionLeft:
            newFrame.origin.x = newFrame.size.width / 2;
            layer.anchorPoint = CGPointMake(.5, 0);
        break;

        case FLFlipViewAnimatorDirectionRight:
            newFrame.origin.x = newFrame.size.width / 2;
            layer.anchorPoint = CGPointMake(.5, 0);
        break;
    }
    
    layer.frame = newFrame;
}

+ (CAAnimation*) createFlipAnimationForLayer:(CALayer*) layer 
                           withFlipDirection:(FLFlipViewAnimatorDirection) flipDirection {
    
    CGFloat start = 0.0f;
    CGFloat finish = 0.0f;
    NSString* keyPath = nil;

    switch(flipDirection) {
        case FLFlipViewAnimatorDirectionUp:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = M_PI;
        break;
        
        case FLFlipViewAnimatorDirectionDown:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = -M_PI;
        break;

        case FLFlipViewAnimatorDirectionLeft:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = M_PI;
        break;

        case FLFlipViewAnimatorDirectionRight:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = -M_PI;
        break;
    }

    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    flipAnimation.fromValue = [NSNumber numberWithDouble:start];
    flipAnimation.toValue = [NSNumber numberWithDouble:finish];
    flipAnimation.fillMode = kCAFillModeForwards;
    flipAnimation.additive = NO;
    flipAnimation.removedOnCompletion = NO;
    return flipAnimation;

}

- (void) setTarget:(id) target {

    self.prepare = ^(id animation){

        CALayer* layer = [animation layerFromTarget:target];
    
        layer.doubleSided = _showBothSidesDuringFlip;
        
        [FLFlipAnimation prepareLayerForFlip:layer inFlipDirection:_flipDirection];
        
        CAAnimation* flipAnimation = [FLFlipAnimation createFlipAnimationForLayer:layer withFlipDirection:_flipDirection];

        [FLFlipAnimation addPerspectiveToLayer:layer withPerspectiveDistance:_perspectiveDistance];
    
        self.commit = ^{
            [layer addAnimation:flipAnimation forKey:@"flip"];    
        };

    };
}


@end
