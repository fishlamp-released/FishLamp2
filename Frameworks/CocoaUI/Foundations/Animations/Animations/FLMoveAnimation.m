//
//  FLMoveAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@implementation FLMoveAnimation

+ (CAAnimation*) animationForLayer:(CALayer*) layer 
                        fromOrigin:(CGPoint) fromOrigin 
                          toOrigin:(CGPoint) toOrigin {
    
    CABasicAnimation *moveFrame = [CABasicAnimation animationWithKeyPath:@"position"];
    [moveFrame setFromValue:[NSValue valueWithPoint:fromOrigin]];
    [moveFrame setToValue:[NSValue valueWithPoint:toOrigin]];
    moveFrame.removedOnCompletion = NO;
    return moveFrame;
}

- (void) prepareAnimator:(FLAnimator*) animator
              fromOrigin:(CGPoint) fromOrigin 
                toOrigin:(CGPoint) toOrigin {

    CALayer* layer = self.layer;
    CAAnimation* moveFrame = [FLMoveAnimation animationForLayer:layer fromOrigin:fromOrigin toOrigin:toOrigin];
    
    [layer addAnimation:moveFrame forKey:@"position"];
//        [layer setFrame:FLRectSetOriginWithPoint([layer frame], fromOrigin)];

    [layer setPosition:fromOrigin];

    animator.commit = ^{
        [layer setPosition:toOrigin];
    
//#if OSX
//        [[layer animator] setFrame:destFrame];
//#else
//        [layer setFrame:destFrame];
//#endif    

    };
}                  

@end

@implementation FLSlideInFromRightAnimation

- (void) prepareAnimator:(FLAnimator*) animator {
    
    CALayer* layer = self.layer;
    [self prepareAnimator:animator 
         fromOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) 
           toOrigin:layer.frame.origin];
}

@end

@implementation FLSlideOutToRightAnimation

- (void) prepareAnimator:(FLAnimator*) animator {
    CALayer* layer = self.layer;
    [self prepareAnimator:animator 
          fromOrigin:layer.frame.origin 
           toOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) ];
}

@end