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

- (id) initWithView:(UIView*) view {
    self = [super initWithView:view];
    if(self) {
    
        _perspectiveDistance = FLFlipAnimationDefaultPerspectiveDistance;
        _showBothSidesDuringFlip = YES;
    
        self.prepare = ^(id animation){
            [animation prepareFlipAnimationForView:view];
        };
    }
        
    return self;
}

- (void) addPerspectiveToView:(UIView*) view {
    if(_perspectiveDistance > 0) {
        CGFloat zDistance = _perspectiveDistance;
        CATransform3D perspective = CATransform3DIdentity; 
        perspective.m34 = -1. / zDistance;

        view.layer.transform = perspective;
    }
}

- (void) prepareFlipAnimationForView:(UIView*) view {
    
    view.layer.doubleSided = _showBothSidesDuringFlip;

    CGFloat start = 0.0f;
    CGFloat finish = 0.0f;
    NSString* keyPath = nil;

    CGRect frame = view.layer.frame;
    
    switch(_flipDirection) {
        case FLFlipViewAnimatorDirectionUp:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = M_PI;
            view.layer.anchorPoint = CGPointMake(0, .5);
            frame.origin.y = frame.size.height / 2;
        break;
        
        case FLFlipViewAnimatorDirectionDown:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = -M_PI;
            view.layer.anchorPoint = CGPointMake(0, .5);
            frame.origin.y = frame.size.height / 2;
        break;

        case FLFlipViewAnimatorDirectionLeft:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = M_PI;
            frame.origin.x = frame.size.width / 2;
            view.layer.anchorPoint = CGPointMake(.5, 0);
        break;

        case FLFlipViewAnimatorDirectionRight:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = -M_PI;
            frame.origin.x = frame.size.width / 2;
            view.layer.anchorPoint = CGPointMake(.5, 0);
        break;
    }

    view.layer.frame = frame;

    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    flipAnimation.fromValue = [NSNumber numberWithDouble:start];
    flipAnimation.toValue = [NSNumber numberWithDouble:finish];
    flipAnimation.fillMode = kCAFillModeForwards;
    flipAnimation.additive = NO;
    flipAnimation.removedOnCompletion = NO;

    [self addPerspectiveToView:view];
    
    self.commit = ^{
        [view.layer addAnimation:flipAnimation forKey:@"flip"];    
    };
}

@end
