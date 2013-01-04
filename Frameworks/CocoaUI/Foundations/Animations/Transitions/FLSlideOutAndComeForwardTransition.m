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

    FLAnimation* animations[] = {
        [FLFadeInAnimation animationWithTarget:viewToShow],
        [FLComeForwardAnimation animationWithTarget:viewToShow],
        [FLSlideOutToRightAnimation animationWithTarget:viewToHide],
        [FLFadeOutAnimation animationWithTarget:viewToHide]
    };
    
    [self setAnimations:[NSArray arrayWithObjects:animations count:4]];
}

@end
