//
//  FLMoveAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@implementation FLMoveAnimation

@synthesize fromFrame = _fromFrame;
@synthesize destinationFrame = _destinationFrame;

- (void) prepare {

    [super prepare];
    
    _fromFrame = [self.targetView frame];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"frame"];
    [animation setFromValue:[NSValue valueWithPoint:_fromFrame.origin]];
    [animation setToValue:[NSValue valueWithPoint:_destinationFrame.origin]];
    animation.removedOnCompletion = YES;
    [self.targetView setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:animation, @"frame", nil]];
}

- (void) commit {
    [super commit];

#if OSX
    [[self.targetView animator] setFrame:_destinationFrame];
#else
    [self.targetView setFrame:_destinationFrame];
#endif
}
@end

@implementation FLSlideInFromRightAnimation

- (void) prepare {
    
    CGRect destFrame = self.targetView.frame;
    CGRect fromFrame = destFrame;
    fromFrame.origin.x = FLRectGetRight(self.targetView.superview.bounds);
    
    self.targetView.frame = fromFrame;
    self.destinationFrame = destFrame;
    
    [super prepare];
}

@end

@implementation FLSlideOutToRightAnimation
- (void) prepare {
    CGRect fromFrame = self.targetView.frame;
    CGRect destFrame = fromFrame;
    destFrame.origin.x = FLRectGetRight(self.targetView.superview.bounds);
    self.destinationFrame = destFrame;
    [super prepare];
}

@end