//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

typedef enum {
    FLFlipAnimationDirectionUp,
    FLFlipAnimationDirectionDown,
    FLFlipAnimationDirectionLeft,
    FLFlipAnimationDirectionRight
} FLFlipAnimationDirection;

@interface FLFlipAnimation : FLAnimation {
@private
    FLFlipAnimationDirection _flipDirection;
}

+ (id) flipAnimation:(FLFlipAnimationDirection) direction withTarget:(id) target withSibling:(id) sibling;

@end


