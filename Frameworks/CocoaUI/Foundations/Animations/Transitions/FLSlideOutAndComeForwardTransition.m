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
        [FLFadeInAnimation animationWithView:viewToShow],
        [FLComeForwardAnimation animationWithView:viewToShow],
        [FLSlideOutToRightAnimation animationWithView:viewToHide],
        [FLFadeOutAnimation animationWithView:viewToHide]
    };
    
    [self setAnimations:[NSArray arrayWithObjects:animations count:4]];
}

@end
