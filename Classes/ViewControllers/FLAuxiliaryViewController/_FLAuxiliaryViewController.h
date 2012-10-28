//
//  _FLAuxiliaryViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAuxiliaryViewController.h"
#import "FLAuxiliaryView.h"

// internal

@interface FLAuxiliaryViewController ()

// internal stuff
@property (readwrite, assign, nonatomic) UIViewController* parentViewController;
@property (readwrite, assign, nonatomic) FLAuxiliaryViewControllerPinnedSide revealSide;
@property (readwrite, strong, nonatomic) id<FLAuxiliaryViewControllerBehavior> behavior;
@property (readwrite, strong, nonatomic) FLDraggableButtonView* draggableButton;

@property (readonly, strong, nonatomic) FLAuxiliaryView* containerView;

// rects
@property (readonly, assign, nonatomic) FLRect onscreenFrame;
@property (readonly, assign, nonatomic) FLRect offscreenFrame;
@property (readonly, assign, nonatomic) FLRect onscreenFrameInHostView;
@property (readonly, assign, nonatomic) FLRect destRectForDraggerViewInHostView;
@property (readonly, assign, nonatomic) FLRect startRectForDraggerViewInHostView;

- (void) _hideAnimationFinished;

@end

@interface UIView (FLTouchableAuxilaryView)
- (void) auxiliaryViewControllerDragWillBegin:(FLAuxiliaryViewController*) controller;
- (void) auxiliaryViewController:(FLAuxiliaryViewController*) controller 
    didFinishDraggingWithResults:(FLViewDraggerResults) results;
@end