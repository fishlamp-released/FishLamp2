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

    self = [super init];
    if(self) {
        self.timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
        self.duration = 0.5;
    
    }

    return self;
}

//- (id) initWithViewToShow:(UIView*) viewToShow 
//               viewToHide:(UIView*) viewToHide {
//
//    self = [super init];
//    if(self) {
//        if(viewToShow) {
//            [self setViewToShow:viewToShow viewToHide:viewToHide];
//        }
//    }
//
//    return self;
//}



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

    self.finish = ^{
        [viewToHide removeFromSuperview];
    };

    [self addAnimationsForViewToShow:viewToShow viewToHide:viewToHide];
}

+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide  {
    FLTransition* transition = FLAutorelease([[[self class] alloc] init]);
    if(viewToShow) {
        [transition setViewToShow:viewToShow viewToHide:viewToHide];
    }

    return transition;
}

- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide {
                         
}                         



@end
