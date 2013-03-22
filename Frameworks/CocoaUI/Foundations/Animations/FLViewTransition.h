//
//  FLViewTransition.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"
#import "FLLayerAnimation.h"

@interface FLViewTransition : FLAnimation {
@private 
    UIView* _viewToShow;
    UIView* _viewToHide;
    NSMutableArray* _showAnimations;
    NSMutableArray* _hideAnimations;
}

- (void) addShowAnimation:(FLLayerAnimation*) animation;
- (void) addHideAnimation:(FLLayerAnimation*) animation;

- (void) startShowingView:(SDKView*) viewToShow 
               viewToHide:(SDKView*) viewToHide
               completion:(FLBlock) completion;

@end
