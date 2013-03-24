//
//  FLFadeAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"


@interface FLOpacityAnimation : FLAnimation {
@private
    CGFloat _startOpacity;
}
@end

@interface FLFadeInAnimation : FLOpacityAnimation {
@private
}
+ (id) fadeInAnimation;; 
@end

@interface FLFadeOutAnimation : FLOpacityAnimation {
@private
}
+ (id) fadeOutAnimation; 
@end
