//
//  FLViewTransition.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLViewTransition.h"

@interface FLViewTransition ()
@property (readwrite, strong, nonatomic) UIView* viewToShow;
@property (readwrite, strong, nonatomic) UIView* viewToHide; 
@end

@implementation FLViewTransition

@synthesize viewToShow = _viewToShow;
@synthesize viewToHide = _viewToHide;

- (id) init {

    self = [super init];
    if(self) {
        self.duration = 0.5;
        
        _showAnimations = [[NSMutableArray alloc] init];
        _hideAnimations = [[NSMutableArray alloc] init];
    }

    return self;
}

#if FL_MRC
- (void) dealloc {
    [_showAnimations release];
    [_hideAnimations release];
    [_viewToShow release];
    [_viewToHide release];
    [super dealloc];
}
#endif

- (void) prepare {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToShow layer];

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
    
    for(FLLayerAnimation* animation in _showAnimations) {
        [animation prepareLayer:hideLayer];
    }
    for(FLLayerAnimation* animation in _hideAnimations) {
        [animation prepareLayer:showLayer];
    }
}

- (void) commit {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToShow layer];

    for(FLLayerAnimation* animation in _showAnimations) {
        [animation commitAnimation:hideLayer];
    }
    for(FLLayerAnimation* animation in _hideAnimations) {
        [animation commitAnimation:showLayer];
    }
}

- (void) finish {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToShow layer];

    for(FLLayerAnimation* animation in _showAnimations) {
        [animation finishAnimation:hideLayer];
    }
    for(FLLayerAnimation* animation in _hideAnimations) {
        [animation finishAnimation:showLayer];
    }
}

- (void) addShowAnimation:(FLLayerAnimation*) animation {
    [_showAnimations addObject:animation];
}

- (void) addHideAnimation:(FLLayerAnimation*) animation {
    [_hideAnimations addObject:animation];
}

- (void) startTransitionWithViewToShow:(SDKView*) viewToShow 
                            viewToHide:(SDKView*) viewToHide
                            completion:(FLAnimationCompletionBlock) completion {
                            
    self.viewToShow = viewToShow;
    self.viewToHide = viewToHide;
    
    [self startAnimating:completion];
}                            

@end
