//
//  FLFadeAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"


@interface FLFadeAnimation : FLAnimation {
@private
}

- (void) prepareAnimator:(FLAnimator*) animator 
             fromOpacity:(CGFloat) fromOpacity 
               toOpacity:(CGFloat) toOpacity;
               
+ (CAAnimation*) animationForLayer:(CALayer*) layer 
                         fromOpacity:(CGFloat) fromOpacity 
                           toOpacity:(CGFloat) toOpacity;
@end

@interface FLFadeOutAnimation : FLFadeAnimation
@end

@interface FLFadeInAnimation : FLFadeAnimation
@end
