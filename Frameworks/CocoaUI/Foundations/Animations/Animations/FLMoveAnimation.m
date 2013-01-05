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

- (void) prepareAnimationWithLayer:(CALayer*) layer
        fromOrigin:(CGPoint) fromOrigin 
          toOrigin:(CGPoint) toOrigin {

    self.prepare = ^(id animation){
    
        CAAnimation* moveFrame = [FLMoveAnimation animationForLayer:layer fromOrigin:fromOrigin toOrigin:toOrigin];
        
        [layer addAnimation:moveFrame forKey:@"position"];
//        [layer setFrame:FLRectSetOriginWithPoint([layer frame], fromOrigin)];

        [layer setPosition:fromOrigin];

        
        [self setCommit:^{
            [layer setPosition:toOrigin];
        
//#if OSX
//        [[layer animator] setFrame:destFrame];
//#else
//        [layer setFrame:destFrame];
//#endif    
    
        }];
    };          
}          

- (void) setTarget:(id) target
        fromOrigin:(CGPoint) fromOrigin 
          toOrigin:(CGPoint) toOrigin {
    [self prepareAnimationWithLayer:[self layerFromTarget:target] fromOrigin:fromOrigin toOrigin:toOrigin];
}          

@end

@implementation FLSlideInFromRightAnimation

- (void) setTarget:(id) target {
    
    CALayer* layer = [self layerFromTarget:target];
    [self prepareAnimationWithLayer:layer 
         fromOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) 
           toOrigin:layer.frame.origin];
}

@end

@implementation FLSlideOutToRightAnimation

- (void) setTarget:(id) target {
    CALayer* layer = [self layerFromTarget:target];
    [self prepareAnimationWithLayer:layer 
         fromOrigin:layer.frame.origin 
           toOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) ];
}

@end