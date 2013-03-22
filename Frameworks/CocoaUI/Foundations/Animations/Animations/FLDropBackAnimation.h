//
//  FLDropBackAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLLayerAnimation.h"

#define FLDropBackAnimationDefaultScale 0.95f

@interface FLDropBackAnimation : FLLayerAnimation 

+ (id) dropBackAnimation;

@property (readwrite, assign, nonatomic) CGFloat scale;

+ (CATransform3D) transformForFrame:(CGRect) frame 
                          withScale:(CGFloat) scaleAmount;

@end

