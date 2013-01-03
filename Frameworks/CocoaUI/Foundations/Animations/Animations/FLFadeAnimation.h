//
//  FLFadeAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLViewAnimation.h"

@interface FLFadeAnimation : FLViewAnimation 
- (void) prepareToFadeView:(UIView*) view fromAlpha:(CGFloat) fromAlpha toAlpha:(CGFloat) toAlpha;
@end

@interface FLFadeOutAnimation : FLFadeAnimation

@end

@interface FLFadeInAnimation : FLFadeAnimation

@end
