//
//  FLSlideInAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLSlideAnimation : FLAnimation {
@private
    FLAnimationDirection _slideDirection;
}
@property (readonly, assign, nonatomic) FLAnimationDirection slideDirection;
@end

@interface FLSlideInAnimation : FLSlideAnimation {
@private
    CGPoint _onScreenOrigin;
    CGPoint _offScreenOrigin;
}
+ (id) slideInAnimation:(FLAnimationDirection) slideInDirection;
@end

@interface FLSlideOutAnimation : FLSlideAnimation {
@private
    CGPoint _onScreenOrigin;
    CGPoint _offScreenOrigin;
}
+ (id) slideOutAnimation:(FLAnimationDirection) slideInDirection;
@end

