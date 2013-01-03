//
//  FLMoveAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@implementation FLMoveAnimation

- (void) prepareToMoveView:(UIView*) view 
                fromOrigin:(CGPoint) fromOrigin 
                  toOrigin:(CGPoint) toOrigin {
    
    CABasicAnimation *moveFrame = [CABasicAnimation animationWithKeyPath:@"frame"];
    [moveFrame setFromValue:[NSValue valueWithPoint:fromOrigin]];
    [moveFrame setToValue:[NSValue valueWithPoint:toOrigin]];
    moveFrame.removedOnCompletion = NO;
    [view setAnimations:[NSDictionary dictionaryWithObject:moveFrame forKey:@"frame"]];

    [view setFrame:FLRectSetOriginWithPoint([view frame], fromOrigin)];
        
    [self setCommit:^{

        CGRect destFrame = FLRectSetOriginWithPoint([view frame], toOrigin);

#if OSX
        [[view animator] setFrame:destFrame];
#else
        [view setFrame:destFrame];
#endif    
    
    }];
}

@end

@implementation FLSlideInFromRightAnimation

- (void) prepareViewAnimation:(UIView*) view {
    self.prepare = ^(id animation){
        [animation prepareToMoveView:view 
                          fromOrigin:CGPointMake(FLRectGetRight(view.superview.bounds), view.frame.origin.y) 
                            toOrigin:view.frame.origin];
    };
}

@end

@implementation FLSlideOutToRightAnimation

- (void) prepareViewAnimation:(UIView*) view {
    self.prepare = ^(id animation){
        [animation prepareToMoveView:view 
                          fromOrigin:view.frame.origin
                            toOrigin:CGPointMake(FLRectGetRight(view.superview.bounds), view.frame.origin.y) ];
    };
}

@end