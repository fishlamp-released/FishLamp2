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
    
    CGPoint _topPosition;
    CGPoint _topAnchor;
    CGPoint _bottomPosition;
    CGPoint _bottomAnchor;
    
    CATransform3D _topTransform;
    CATransform3D _bottomTransform;
    
}

+ (id) flipTransition:(FLAnimationDirection) animationDirection;

@property (readwrite, assign, nonatomic) CGFloat perspectiveDistance;  // defaults to FLFlipAnimationDefaultPerspectiveDistance

@end


