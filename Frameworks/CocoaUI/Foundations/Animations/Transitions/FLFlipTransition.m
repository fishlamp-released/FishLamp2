//
//  FLFlipViewAnimator.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFlipTransition.h"
#import "FLFlipAnimation.h"

@implementation FLFlipTransition
@synthesize flipDirection = _flipDirection;
@synthesize perspectiveDistance = _perspectiveDistance;

- (id) init {
    self = [super init];
    if(self) {
        _perspectiveDistance = FLFlipAnimationDefaultPerspectiveDistance;
        self.duration = 0.5;
    }
    return self;
}

- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide {

    FLFlipAnimation* show = [FLFlipAnimation animationWithTarget:viewToShow];
    show.flipDirection = _flipDirection;
    show.showBothSidesDuringFlip = NO;
    show.perspectiveDistance = _perspectiveDistance;

    FLFlipAnimation* hide = [FLFlipAnimation animationWithTarget:viewToHide];
    hide.flipDirection = FLFlipViewAnimatorDirectionOpposite(_flipDirection);;
    hide.showBothSidesDuringFlip = NO;
    hide.perspectiveDistance = _perspectiveDistance;

    FLFlipAnimation* animations[] = {
        show, 
        hide
    };
    
    [self setAnimations:[NSArray arrayWithObjects:animations count:2]];
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
    
    