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
#import "FLComeForwardAnimation.h"

@implementation FLSlideInAndDropTransition

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {
               
    self = [super initWithViewToShow:viewToShow viewToHide:viewToHide];
    if(self) {
        [self addAnimation:[FLFadeOutAnimation animationWithTarget:viewToHide]];
        [self addAnimation:[FLDropBackAnimation animationWithTarget:viewToHide]];
//        [self addAnimation:[FLSlideInFromRightAnimation animationWithTarget:viewToShow]];
        [self addAnimation:[FLComeForwardAnimation animationWithTarget:viewToShow]];
        [self addAnimation:[FLFadeInAnimation animationWithTarget:viewToShow]];
    }
    
    return self;
}

@end
