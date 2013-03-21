//
//  FLTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTransition.h"

@interface FLTransition ()
//@property (readwrite, strong, nonatomic) UIView* viewToShow;
//@property (readwrite, strong, nonatomic) UIView* viewToHide; 
@end

@implementation FLTransition

@synthesize viewToShow = _viewToShow;
@synthesize viewToHide = _viewToHide;

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide {

    self = [super init];
    if(self) {
        self.viewToShow = viewToShow;
        self.viewToHide = viewToHide;
        self.duration = 0.5;
    }

    return self;
}

#if FL_MRC
- (void) dealloc {
    [_viewToShow release];
    [_viewToHide release];
    [super dealloc];
}
#endif

- (void) startTransition:(FLAnimationCompletionBlock) completion {

}


+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide {
    return FLAutorelease([[[self class] alloc] initWithViewToShow:viewToShow viewToHide:viewToHide]);
}

- (void) prepareLayer:(CALayer*) layer  {

    UIView* viewToShow = self.viewToShow;
    UIView* viewToHide = self.viewToHide;

    FLAssertNotNil(viewToShow);
    FLAssertNotNil(viewToHide);
    FLAssertNotNil(viewToHide.superview);

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

- (void) finishAnimation:(CALayer*) layer {
    [self.viewToHide removeFromSuperview];
}

@end
