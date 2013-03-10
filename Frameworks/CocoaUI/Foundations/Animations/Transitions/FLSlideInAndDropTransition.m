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
        [self addAnimation:[FLFadeOutAnimation fadeOutAnimation]];
        [self addAnimation:[FLDropBackAnimation dropBackAnimation]];
//        [self addAnimation:[FLSlideInAnimation animationWithTarget:viewToShow]];
        [self addAnimation:[FLComeForwardAnimation comeForwardAnimation]];
        [self addAnimation:[FLFadeInAnimation fadeInAnimation]];
    }
    
    return self;
}

@end
