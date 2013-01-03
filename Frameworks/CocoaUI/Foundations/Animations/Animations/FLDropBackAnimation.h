//
//  FLDropBackAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLViewAnimation.h"

extern CATransform3D FLMakeShrinkAwayTransform(UIView* view, CGFloat scaleAmount);
#define kScaleSmall 0.95f

@interface FLDropBackAnimation : FLViewAnimation
@end

