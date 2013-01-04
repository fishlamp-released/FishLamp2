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
    
    CABasicAnimation *moveFrame = [CABasicAnimation animationWithKeyPath:@"frame"];
    [moveFrame setFromValue:[NSValue valueWithPoint:fromOrigin]];
    [moveFrame setToValue:[NSValue valueWithPoint:toOrigin]];
    moveFrame.removedOnCompletion = NO;

}

- (void) setTarget:(id) target
        fromOrigin:(CGPoint) fromOrigin 
          toOrigin:(CGPoint) toOrigin {

    self.prepare = ^(id animation){
    
        CALayer* layer = [self layerFromTarget:target];
        
        CAAnimation* moveFrame = [FLMoveAnimation animationForLayer:layer fromOrigin:fromOrigin toOrigin:toOrigin];
        
        [layer addAnimation:moveFrame forKey:@"frame"];
        [layer setFrame:FLRectSetOriginWithPoint([layer frame], fromOrigin)];
        
        [self setCommit:^{
            [layer setFrame:FLRectSetOriginWithPoint([layer frame], toOrigin)];
        
//#if OSX
//        [[layer animator] setFrame:destFrame];
//#else
//        [layer setFrame:destFrame];
//#endif    
    
        }];
    };          
}          

@end

@implementation FLSlideInFromRightAnimation

- (void) setTarget:(id) target {
    [self setTarget:target fromOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) toOrigin:layer.frame.origin];
}

@end

@implementation FLSlideOutToRightAnimation

- (void) setTarget:(id) target {
    [self setTarget:target fromOrigin:layer.frame.origi toOrigin:CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) ];
}

@end