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
    NSMutableArray* _animations;
}

- (void) addAnimation:(FLLayerAnimation*) animation;

@property (readonly, strong, nonatomic) UIView* viewToShow;
@property (readonly, strong, nonatomic) UIView* viewToHide; 

- (void) startTransitionWithViewToShow:(SDKView*) view 
                            viewToHide:(SDKView*) toHide
                            completion:(FLBlock) completion;

@end
