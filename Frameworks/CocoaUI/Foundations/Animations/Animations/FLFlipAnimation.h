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

#define FLFlipAnimationDefaultPerspectiveDistance 1500.0f

@interface FLFlipAnimation : FLAnimation

@property (readwrite, assign, nonatomic) FLFlipAnimationDirection flipDirection;

// defaults to yes
@property (readwrite, assign, nonatomic) BOOL showBothSidesDuringFlip; 

// defaults to FLFlipAnimationDefaultPerspectiveDistance
@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  

- (id) initWithFlipDirection:(FLFlipAnimationDirection) direction;
+ (id) flipAnimation:(FLFlipAnimationDirection) direction;

@end


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
