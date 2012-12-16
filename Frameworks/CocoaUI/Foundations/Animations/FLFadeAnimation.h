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
    CGFloat _fromAlpha;
    CGFloat _toAlpha;
}
@property (readonly, assign, nonatomic) CGFloat fromAlpha;
@property (readwrite, assign, nonatomic) CGFloat toAlpha;

@end

@interface FLFadeOutAnimation : FLFadeAnimation

@end

@interface FLFadeInAnimation : FLFadeAnimation

@end
