//
//  FLSlideOutAndComeForwardTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSlideOutAndComeForwardTransition.h"


#import "FLFadeAnimation.h"
#import "FLMoveAnimation.h"
#import "FLComeForwardAnimation.h"

@implementation FLSlideOutAndComeForwardTransition

- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide {

    [self addAnimation:[FLFadeInAnimation animationWithTarget:viewToShow]];
    [self addAnimation:[FLComeForwardAnimation animationWithTarget:viewToShow]];
    [self addAnimation:[FLSlideOutToRightAnimation animationWithTarget:viewToHide]];
    [self addAnimation:[FLFadeOutAnimation animationWithTarget:viewToHide]];
}

@end
