//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

typedef enum {
    FLFlipAnimationDirectionUp,
    FLFlipAnimationDirectionDown,
    FLFlipAnimationDirectionLeft,
    FLFlipAnimationDirectionRight
} FLFlipAnimationDirection;

NS_INLINE
FLFlipAnimationDirection FLFlipAnimationDirectionOpposite(FLFlipAnimationDirection direction) {
    switch(direction) {
        case FLFlipAnimationDirectionUp: 
            return FLFlipAnimationDirectionDown;
        case FLFlipAnimationDirectionDown: 
            return FLFlipAnimationDirectionUp;
        case FLFlipAnimationDirectionLeft: 
            return FLFlipAnimationDirectionRight;
        case FLFlipAnimationDirectionRight: 
            return FLFlipAnimationDirectionLeft;
    }
}

#define FLFlipAnimationDefaultPerspectiveDistance 1500.0f

@interface FLFlipAnimation : FLAnimation {
@private
    FLFlipAnimationDirection _flipDirection;
    BOOL _showBothSidesDuringFlip;
    CGFloat _perspectiveDistance;
}

@property (readwrite, assign, nonatomic) FLFlipAnimationDirection flipDirection;

@property (readwrite, assign, nonatomic) BOOL showBothSidesDuringFlip; // defaults to yes

@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance


// utils

+ (void) addPerspectiveToLayer:(CALayer*) layer 
       withPerspectiveDistance:(CGFloat) distance;
       
+ (void) prepareLayerForFlip:(CALayer*) layer 
             inFlipDirection:(FLFlipAnimationDirection) flipDirection;
   
+ (CAAnimation*) createFlipAnimationForLayer:(CALayer*) layer 
                           withFlipDirection:(FLFlipAnimationDirection) flipDirection;

@end
