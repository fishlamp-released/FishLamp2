//
//  FLSlideInAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSlideInAnimation.h"


@implementation FLSlideInAnimation

- (id) initWithSlideDirection:(FLAnimationDirection) direction {
    self = [super init];
    if(self) {
        _slideDirection = direction;
    }
    return self;
}

+ (id) slideInAnimation:(FLAnimationDirection)slideInDirection {
    return FLAutorelease([[[self class] alloc] initWithSlideDirection:slideDirection]);
}

- (void) prepareLayer:(CALayer*) layer {

    _onScreenOrigin = layer.frame.origin;
    
    CGRect frame = layer.frame;
    CGRect bounds = layer.superlayer.bounds;
    
    switch(self.direction) {
        case FLAnimationDirectionUp:
            _offScreenOrigin = CGPointMake(frame.origin.x, bounds.origin.y);
        break;

        case FLAnimationDirectionDown:
            _offScreenOrigin = CGPointMake(frame.origin.x, FLRectGetBottom(bounds) - frame.size.height);
        break;
        
        case FLAnimationDirectionLeft:
            _offScreenOrigin = CGPointMake(bounds.origin.x - frame.size.width, frame.origin.y);
        break;
        
        
        case FLAnimationDirectionRight:
            _offScreenOrigin = CGPointMake(FLRectGetRight(bounds) + frame.size.width, frame.origin.y);
        break;
    
    }

    


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
