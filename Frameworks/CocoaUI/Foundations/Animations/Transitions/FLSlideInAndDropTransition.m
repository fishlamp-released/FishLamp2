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

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {
    
    self = [super initWithViewToShow:viewToShow viewToHide:viewToHide];
    if(self) {
        self.prepare = ^(id animation) {
            [animation addAnimation:[FLFadeOutAnimation animationWithView:viewToHide]];
            [animation addAnimation:[FLDropBackAnimation animationWithView:viewToHide]];
            [animation addAnimation:[FLSlideInFromRightAnimation animationWithView:viewToShow]];
            [animation addAnimation:[FLFadeInAnimation animationWithView:viewToShow]];
        };
    }
    
    return self;
}

@end
