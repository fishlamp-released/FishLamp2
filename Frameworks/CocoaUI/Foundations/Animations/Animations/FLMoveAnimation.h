//
//  FLMoveAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLAnimation.h"

@interface FLMoveAnimation : FLAnimation
@property (readwrite, assign, nonatomic) CGPoint startPoint;
@property (readwrite, assign, nonatomic) CGPoint finishPoint;
+ (id) moveAnimation:(CGPoint) destination;
@end

@interface FLSlideInAnimation : FLMoveAnimation
+ (id) slideInAnimation;
@end

@interface FLSlideOutAnimation : FLMoveAnimation
+ (id) slideOutAnimation;
@end

