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
    CGFloat _scale;
    
    CATransform3D _start;
    CATransform3D _finish;
    CGRect _startFrame;
}

@property (readwrite, assign, nonatomic) CGFloat scale;

@end