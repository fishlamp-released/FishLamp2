//
//  FLFlipAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLViewTransition.h"
#import "FLFlipAnimation.h"

@interface FLFlipTransition : FLViewTransition {
@private
    FLFlipAnimationDirection _flipDirection;
    CGFloat _perspectiveDistance;
}

+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide
                  flipDirection:(FLFlipAnimationDirection) flipDirection;

@property (readwrite, assign, nonatomic) FLFlipAnimationDirection flipDirection;
@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance

@end


