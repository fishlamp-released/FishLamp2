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
        self.prepare = ^(id animation) {
            [animation addAnimation:[FLFadeInAnimation animationWithView:viewToShow]];
            [animation addAnimation:[FLComeForwardAnimation animationWithView:viewToShow]];
            [animation addAnimation:[FLSlideOutToRightAnimation animationWithView:viewToHide]];
            [animation addAnimation:[FLFadeOutAnimation animationWithView:viewToHide]];
        };
    }
    
    return self;
}

@end
