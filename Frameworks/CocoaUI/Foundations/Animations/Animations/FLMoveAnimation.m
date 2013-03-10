//
//  FLMoveAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@interface FLMoveAnimation ()

// for subclasses
- (CAAnimation*) CAAnimation;
@end

@implementation FLMoveAnimation {
@private
    CGPoint _startPoint;
    CGPoint _finishPoint;
    BOOL _setStartPoint;
    BOOL _setFinishPoint;
}
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
    return moveFrame;
}

- (void) prepareLayer:(CALayer*) layer {
    if(_setStartPoint) {
        [layer setPosition:_startPoint];
    }
    else {
        _startPoint = layer.position;
    }
}

- (void) commitAnimation:(CALayer*) layer {
    FLAssert_(_setFinishPoint);
    
    [layer addAnimation:[self CAAnimation] forKey:@"position"];
    [layer setPosition:_finishPoint];
}

- (void) finishAnimation:(CALayer*) layer {
}

@end

@implementation FLSlideInAnimation 

+ (id) slideInAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareLayer:(CALayer*) layer {
    self.startPoint = CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y);
    self.finishPoint = layer.frame.origin;
    [super prepareLayer:layer];
}

@end

@implementation FLSlideOutAnimation 

+ (id) slideOutAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareLayer:(CALayer*) layer {
    self.startPoint = layer.frame.origin;
    self.finishPoint = CGPointMake(FLRectGetRight(layer.superlayer.bounds), layer.frame.origin.y) ;
    [super prepareLayer:layer];
}

@end

