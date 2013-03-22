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
    FLAnimationDirection _flipDirection;
    CGFloat _perspectiveDistance;
}

@property (readwrite, assign, nonatomic) FLAnimationDirection flipDirection;
@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance

@end


