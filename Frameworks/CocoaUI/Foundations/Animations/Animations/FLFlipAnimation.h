//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLLayerAnimation.h"


#define FLFlipAnimationDefaultPerspectiveDistance 1500.0f

@interface FLFlipAnimation : FLLayerAnimation {
@private
    BOOL _showBothSidesDuringFlip;
    CGFloat _perspectiveDistance;
    CGPoint _position;
    CGPoint _anchorPoint;
}

// defaults to yes
@property (readwrite, assign, nonatomic) BOOL showBothSidesDuringFlip; 

// defaults to FLFlipAnimationDefaultPerspectiveDistance
@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  

- (id) initWithFlipDirection:(FLAnimationDirection) direction;
+ (id) flipAnimation:(FLAnimationDirection) direction;

@end


