//
//  FLTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTransition.h"

@implementation FLTransition

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {

    self = [super init];
    if(self) {
        FLAssertNotNil_(viewToShow);
        FLAssertNotNil_(viewToHide);
        FLAssertNotNil_(viewToHide.superview);

        self.timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
    }

    return self;
}

+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide  {
    return FLAutorelease([[[self class] alloc] initWithViewToShow:viewToShow viewToHide:viewToHide]);
}

- (void) prepareTransitionWithViewToShow:(UIView*) viewToShow 
                              viewToHide:(UIView*) viewToHide {
    
    if(!CGRectEqualToRect(viewToShow.frame, viewToHide.frame)) {
        viewToShow.frame = viewToHide.frame;
    }
    
    viewToShow.hidden = NO;

    if(viewToShow.superview == nil) {
        [viewToHide.superview addSubview:viewToShow 
                              positioned:NSWindowBelow 
                              relativeTo:viewToHide];
    }
}

- (void) finishTransitionWithViewToShow:(UIView*) viewToShow 
                             viewToHide:(UIView*) viewToHide {
    [viewToHide removeFromSuperview];
}

@end
