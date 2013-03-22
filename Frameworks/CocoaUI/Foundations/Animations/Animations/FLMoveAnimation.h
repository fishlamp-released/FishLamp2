//
//  FLMoveAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLLayerAnimation.h"

@interface FLMoveAnimation : FLLayerAnimation
@property (readwrite, assign, nonatomic) CGPoint startPoint;
@property (readwrite, assign, nonatomic) CGPoint finishPoint;
+ (id) moveAnimation:(CGPoint) destination;
@end

@interface FLSlideInAnimation : FLMoveAnimation {
@private
    FLAnimationDirection _slideDirection;
}
+ (id) slideInAnimation:(FLAnimationDirection) slideInDirection;
@end

@interface FLSlideOutAnimation : FLMoveAnimation
+ (id) slideOutAnimation;
@end

