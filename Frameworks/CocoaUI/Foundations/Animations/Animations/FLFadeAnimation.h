//
//  FLFadeAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLayerAnimation.h"


@interface FLFadeAnimation : FLLayerAnimation {
@private
    CGFloat _fromOpacity;
    CGFloat _toOpactity;
}

+ (id) fadeAnimation;
               
@property (readwrite, assign, nonatomic) CGFloat fromOpacity;
@property (readwrite, assign, nonatomic) CGFloat toOpacity;
                           
- (void) setFadeToOpacity:(CGFloat) toOpacity 
              fromOpacity:(CGFloat) fromOpacity;                           
                           
@end

@interface FLFadeInAnimation : FLLayerAnimation {
@private
}
+ (id) fadeInAnimation;; 
@end

@interface FLFadeOutAnimation : FLLayerAnimation {
@private
}
+ (id) fadeOutAnimation; 
@end
