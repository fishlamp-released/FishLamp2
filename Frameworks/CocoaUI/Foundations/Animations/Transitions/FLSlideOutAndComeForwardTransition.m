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



- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {
               
    self = [super initWithViewToShow:viewToShow viewToHide:viewToHide];
    if(self) {
        [self addAnimation:[FLFadeInAnimation fadeInAnimation]];
        [self addAnimation:[FLComeForwardAnimation comeForwardAnimation]];
        [self addAnimation:[FLSlideOutAnimation slideOutAnimation]];
        [self addAnimation:[FLFadeOutAnimation fadeOutAnimation]];
    }
    return self;
}

@end
