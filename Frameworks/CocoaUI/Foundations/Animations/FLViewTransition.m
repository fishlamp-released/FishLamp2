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
    [_viewToHide release];
    [super dealloc];
}
#endif

- (void) prepareTransition {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToHide layer];

    UIView* viewToShow = self.viewToShow;
    UIView* viewToHide = self.viewToHide;

    FLAssertNotNil(viewToShow);
    FLAssertNotNil(viewToHide);
    FLAssertNotNil(viewToHide.superview);

//    if(!CGRectEqualToRect(viewToShow.frame, viewToHide.frame)) {
//        viewToShow.frame = viewToHide.frame;
//    }
    
    viewToShow.hidden = NO;
    viewToHide.hidden = NO;

//    if(viewToShow.superview == nil) {
//        [viewToHide.superview addSubview:viewToShow 
//                              positioned:NSWindowBelow 
//                              relativeTo:viewToHide];
//    }

    for(FLLayerAnimation* animation in _hideAnimations) {
        animation.duration = self.duration;
        animation.timing = self.timing;

        [animation prepareAnimation:hideLayer];
    }

    for(FLLayerAnimation* animation in _showAnimations) {
        animation.duration = self.duration;
        animation.timing = self.timing;

        [animation prepareAnimation:showLayer];
    }
}

- (void) commitTransition {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToHide layer];

    for(FLLayerAnimation* animation in _hideAnimations) {
        [animation commitAnimation:hideLayer];
    }
    for(FLLayerAnimation* animation in _showAnimations) {
        [animation commitAnimation:showLayer];
    }
}

- (void) finishTransition {
    CALayer* showLayer = [_viewToShow layer];
    CALayer* hideLayer = [_viewToHide layer];

    for(FLLayerAnimation* animation in _hideAnimations) {
        [animation finishAnimation:hideLayer];
    }
    for(FLLayerAnimation* animation in _showAnimations) {
        [animation finishAnimation:showLayer];
    }
    self.viewToHide.hidden = YES;
}

- (void) addShowAnimation:(FLLayerAnimation*) animation {
    [_showAnimations addObject:animation];
}

- (void) addHideAnimation:(FLLayerAnimation*) animation {
    [_hideAnimations addObject:animation];
}

- (void) startShowingView:(SDKView*) viewToShow 
               viewToHide:(SDKView*) viewToHide
               completion:(FLBlock) completion {
                            
    self.viewToShow = viewToShow;
    self.viewToHide = viewToHide;
    
    [self startAnimationWithPrepareBlock:^{ [self prepareTransition]; }
                           commitBlock:^{ [self commitTransition]; }
                           finishBlock:^{ [self finishTransition]; }
                       completionBlock:completion];
}                            








@end
