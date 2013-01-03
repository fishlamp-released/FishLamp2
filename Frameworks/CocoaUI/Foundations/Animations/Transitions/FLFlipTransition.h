//
//  FLFlipViewAnimator.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTransition.h"
#import "FLFlipAnimation.h"

@interface FLFlipTransition : FLTransition {
@private
    FLFlipViewAnimatorDirection _flipDirection;
    CGFloat _perspectiveDistance;
}

@property (readwrite, assign, nonatomic) FLFlipViewAnimatorDirection flipDirection;
@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance

@end


