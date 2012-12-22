//
//  FLFlipAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFlipAnimation.h"

@implementation NSView (MCAdditions)

-(CALayer *)layerFromContents
{
    CALayer *newLayer = [CALayer layer];
    newLayer.bounds = self.bounds;
    NSBitmapImageRep *bitmapRep = [self bitmapImageRepForCachingDisplayInRect:self.bounds];
    [self cacheDisplayInRect:self.bounds toBitmapImageRep:bitmapRep];
    newLayer.contents = (id)bitmapRep.CGImage;
    return newLayer;
}

@end

@interface FLFlipAnimation ()
@property (readwrite, assign, nonatomic) FLFlipAnimationDirection flipDirection;
@end

@implementation FLFlipAnimation

@synthesize flipDirection = _flipDirection;

+ (id) flipAnimation:(FLFlipAnimationDirection) direction withTarget:(id) target withSibling:(id) sibling {
    FLFlipAnimation* animation = [FLFlipAnimation animation:target];
    animation.sibling = sibling;
    animation.flipDirection = direction;
    return animation;
}

#define FLShrunkTransform(view) \
    CATransform3DConcat(CATransform3DMakeTranslation( (view.frame.size.width * (1.0 - kScaleSmall)) / 2.0f,  (view.frame.size.height * (1.0 - kScaleSmall)), 0), CATransform3DMakeScale(kScaleSmall, kScaleSmall, 1))

//    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scale.fromValue =   [NSValue valueWithCATransform3D:self.targetView.layer.transform];
//    scale.toValue =     [NSValue valueWithCATransform3D:FLShrunkTransform(self.targetView)];
//    scale.removedOnCompletion = YES;
//    [self.targetView.layer addAnimation:scale forKey:@"transform"];
//    self.targetView.layer.transform = FLShrunkTransform(self.targetView);


- (CAAnimation*) createAnimation:(UIView*) view start:(CGFloat) start finish:(CGFloat) finish path:(NSString*) path {
    if(view) {
    
//        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"]
//        scale.fromValue =   [NSValue valueWithCATransform3D:CATransform3DIdentity];
//        scale.toValue =     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(1.0, finish,  1.0, 1.0)];
//        scale.removedOnCompletion = YES;
//        [self.targetView.layer addAnimation:scale forKey:@"transform"];
//        self.targetView.layer.transform = FLShrunkTransform(self.targetView);
//        
    
        CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:path];
        flipAnimation.fromValue = [NSNumber numberWithDouble:start];
        flipAnimation.toValue = [NSNumber numberWithDouble:finish];
        flipAnimation.fillMode = kCAFillModeForwards;
        flipAnimation.additive = NO;
        flipAnimation.removedOnCompletion = NO;
//        [view.layer addAnimation:flipAnimation forKey:path];
        return flipAnimation;
    }
    
    return nil;
}

- (void) prepare { 
    [super prepare];

    CGFloat start = 0.0f;
    CGFloat finish = 0.0f;
    NSString* keyPath = nil;
    
    switch(self.flipDirection) {
        case FLFlipAnimationDirectionUp:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = M_PI;
        break;
        
        case FLFlipAnimationDirectionDown:
            keyPath = @"transform.rotation.x";
            start = 0.0f;
            finish = -M_PI;
        break;

        case FLFlipAnimationDirectionLeft:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = M_PI;
        break;

        case FLFlipAnimationDirectionRight:
            keyPath = @"transform.rotation.y";
            start = 0.0f;
            finish = -M_PI;
        break;
    }
//    CGFloat startValue = beginsOnTop ? 0.0f : M_PI;
//    CGFloat endValue = beginsOnTop ? -M_PI : 0.0f;
    
    CAAnimation* topAnimation =     [self createAnimation:self.targetView start:start finish:finish path:keyPath];
    CAAnimation* bottomAnimation =  [self createAnimation:self.siblingView start:-finish finish:start path:keyPath];
    FLAssertNotNil_(topAnimation);
    FLAssertNotNil_(bottomAnimation);

    UIView* topView = self.targetView;
    FLAssertNotNil_(topView);

    UIView* hostView = topView.superview;
    FLAssertNotNil_(hostView);

    UIView* bottomView = self.siblingView;
    FLAssertNotNil_(bottomView);
    bottomView.frame = topView.frame;
    bottomView.hidden = NO;

    CALayer* topLayer = [topView layer];
    CALayer* bottomLayer = [bottomView layer];
    FLAssertNotNil_(topLayer);
    FLAssertNotNil_(bottomLayer);

    topLayer.anchorPoint = CGPointMake(0, .5);
    bottomLayer.anchorPoint = CGPointMake(0, .5);

    topLayer.frame = FLRectMove(topLayer.frame, 0, topLayer.frame.size.height / 2);
    bottomLayer.frame = topLayer.frame; // FLRectMove(topLayer.frame, 0, -(topLayer.frame.size.height / 2));

    

    CGFloat zDistance = 1500.0f;
    CATransform3D perspective = CATransform3DIdentity; 
    perspective.m34 = -1. / zDistance;
    topLayer.transform = perspective;
    bottomLayer.transform = perspective;
    bottomLayer.doubleSided = NO;
    
    topLayer.doubleSided = NO;
    self.commitBlock = ^(FLAnimation* animation) {
        [topLayer addAnimation:topAnimation forKey:@"flip"];
        [bottomLayer addAnimation:bottomAnimation forKey:@"flip"];
    };
    
    self.finishBlock = ^(FLAnimation* animation) {
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
        topView.hidden = YES;
        [CATransaction commit];
    };
}




@end


//    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    CGFloat startValue = beginsOnTop ? 0.0f : M_PI;
//    CGFloat endValue = beginsOnTop ? -M_PI : 0.0f;
//    flipAnimation.fromValue = [NSNumber numberWithDouble:startValue];
//    flipAnimation.toValue = [NSNumber numberWithDouble:endValue];
//    
//    // Shrinking the view makes it seem to move away from us, for a more natural effect
//    // Can also grow the view to make it move out of the screen
//    CABasicAnimation *shrinkAnimation = nil;
//    if ( scaleFactor != 1.0f ) {
//        shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        shrinkAnimation.toValue = [NSNumber numberWithFloat:scaleFactor];
//        
//        // We only have to animate the shrink in one direction, then use autoreverse to "grow"
//        shrinkAnimation.duration = aDuration * 0.5;
//        shrinkAnimation.autoreverses = YES;
//    }
//    
//    // Combine the flipping and shrinking into one smooth animation
//    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//    animationGroup.animations = [NSArray arrayWithObjects:flipAnimation, shrinkAnimation, nil];
//    
//    // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
//    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animationGroup.duration = aDuration;
//    
//    // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
//    animationGroup.fillMode = kCAFillModeForwards;
//    animationGroup.removedOnCompletion = NO;
//    
//    return animationGroup;
    
    