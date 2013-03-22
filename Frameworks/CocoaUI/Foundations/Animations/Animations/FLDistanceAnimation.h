//
//  FLComeForwardAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLLayerAnimation.h"

#define FLDropBackAnimationDefaultScale 0.95f

@interface FLDistanceAnimation : FLLayerAnimation {
@private
    CGFloat _startScale;
    CGFloat _finishScale;
    
    CATransform3D _startTransform;
    CATransform3D _finishTransform;
    CATransform3D _originalTransform;
}

+ (id) distanceAnimation:(CGFloat) scale finishScale:(CGFloat) finishScale;

@property (readwrite, assign, nonatomic) CGFloat scale;

@end