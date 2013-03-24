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
    CGFloat _fromOpacity;
    CGFloat _toOpacity;
}

+ (id) fadeAnimation;
               
@property (readwrite, assign, nonatomic) CGFloat fromOpacity;
@property (readwrite, assign, nonatomic) CGFloat toOpacity;
                           
- (void) setFadeToOpacity:(CGFloat) toOpacity 
              fromOpacity:(CGFloat) fromOpacity;                           
                           
@end

@interface FLFadeInAnimation : FLAnimation {
@private
}
+ (id) fadeInAnimation;; 
@end

@interface FLFadeOutAnimation : FLAnimation {
@private
}
+ (id) fadeOutAnimation; 
@end
