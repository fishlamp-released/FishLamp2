//
//  FLMoveAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@interface FLMoveAnimation ()

@end

@implementation FLMoveAnimation 
@synthesize startPoint = _startPoint;
@synthesize finishPoint = _finishPoint;

- (id) initWithDestination:(CGPoint) point {
    self = [super init];
    if(self) {
        self.finishPoint = point;
    }
    return self;
}

+ (id) moveAnimation:(CGPoint) destination  {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setStartPoint: (CGPoint) point {
    _startPoint = point;
    _setStartPoint = YES;
}

- (void) setFinishPoint: (CGPoint) point {
    _finishPoint = point;
    _setFinishPoint = YES;
}

- (CAAnimation*) CAAnimation {

    CABasicAnimation *moveFrame = [CABasicAnimation animationWithKeyPath:@"position"];
    [moveFrame setFromValue:[NSValue valueWithPoint:_startPoint]];
    [moveFrame setToValue:[NSValue valueWithPoint:_finishPoint]];
    moveFrame.removedOnCompletion = NO;
    moveFrame.fillMode = kCAFillModeBoth;
    [self configureAnimation:moveFrame];
    return moveFrame;
}

- (void) prepareAnimation:(CALayer*) layer {
    if(_setStartPoint) {
        [layer setPosition:_startPoint];
    }
    else {
        _startPoint = layer.position;
    }
}

- (void) commitAnimation:(CALayer*) layer {
//    FLAssert(_setFinishPoint);
    
    [layer addAnimation:[self CAAnimation] forKey:@"position"];
    [layer setPosition:_finishPoint];
}

- (void) finishAnimation:(CALayer*) layer {
//   [layer setPosition:_finishPoint];
}

@end

