//
//  FLTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTransition.h"

@implementation FLTransition

- (id) init {
    return [self initWithViewToShow:nil viewToHide:nil];
}

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {

    self = [super init];
    if(self) {
        self.timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
        if(viewToShow) {
            [self setViewToShow:viewToShow viewToHide:viewToHide];
        }
    }

    return self;
}

+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide  {
    return FLAutorelease([[[self class] alloc] initWithViewToShow:viewToShow viewToHide:viewToHide]);
}

- (void) setViewToShow:(UIView*) viewToShow viewToHide:(UIView*) viewToHide {

    FLAssertNotNil_(viewToShow);
    FLAssertNotNil_(viewToHide);
    FLAssertNotNil_(viewToHide.superview);

    if(!CGRectEqualToRect(viewToShow.frame, viewToHide.frame)) {
        viewToShow.frame = viewToHide.frame;
    }
    
    viewToShow.hidden = NO;

    if(viewToShow.superview == nil) {
        [viewToHide.superview addSubview:viewToShow 
                              positioned:NSWindowBelow 
                              relativeTo:viewToHide];
    }

    self.cleanup = ^{
        [viewToHide removeFromSuperview];
    };

    [self addAnimationsForViewToShow:viewToShow viewToHide:viewToHide];
}

- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide {
                         
}                         



@end
