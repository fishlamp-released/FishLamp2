//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

typedef enum {
    FLFlipViewAnimatorDirectionUp,
    FLFlipViewAnimatorDirectionDown,
    FLFlipViewAnimatorDirectionLeft,
    FLFlipViewAnimatorDirectionRight
} FLFlipViewAnimatorDirection;

NS_INLINE
FLFlipViewAnimatorDirection FLFlipViewAnimatorDirectionOpposite(FLFlipViewAnimatorDirection direction) {
    switch(direction) {
        case FLFlipViewAnimatorDirectionUp: 
            return FLFlipViewAnimatorDirectionDown;
        case FLFlipViewAnimatorDirectionDown: 
            return FLFlipViewAnimatorDirectionUp;
        case FLFlipViewAnimatorDirectionLeft: 
            return FLFlipViewAnimatorDirectionRight;
        case FLFlipViewAnimatorDirectionRight: 
            return FLFlipViewAnimatorDirectionLeft;
    }
}

#define FLFlipAnimationDefaultPerspectiveDistance 1500.0f

@interface FLFlipAnimation : FLAnimation {
@private
    FLFlipViewAnimatorDirection _flipDirection;
    BOOL _showBothSidesDuringFlip;
    CGFloat _perspectiveDistance;
}

@property (readwrite, assign, nonatomic) FLFlipViewAnimatorDirection flipDirection;

@property (readwrite, assign, nonatomic) BOOL showBothSidesDuringFlip; // defaults to yes

@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance


@end
