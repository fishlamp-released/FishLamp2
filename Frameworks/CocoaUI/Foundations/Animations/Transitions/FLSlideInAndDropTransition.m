//
//  FLSlideAndDropTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSlideInAndDropTransition.h"

#import "FLFadeAnimation.h"
#import "FLMoveAnimation.h"
#import "FLDropBackAnimation.h"

@implementation FLSlideInAndDropTransition

- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide {

    FLAnimation* animations[] = {
        [FLFadeOutAnimation animationWithTarget:viewToHide],
        [FLDropBackAnimation animationWithTarget:viewToHide],
        [FLSlideInFromRightAnimation animationWithTarget:viewToShow],
        [FLFadeInAnimation animationWithTarget:viewToShow]
    };
    [self setAnimations:[NSArray arrayWithObjects:animations count:4]];
}

@end
