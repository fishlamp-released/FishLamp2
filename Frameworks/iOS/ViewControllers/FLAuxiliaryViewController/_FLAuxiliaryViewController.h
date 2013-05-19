//
//  _FLAuxiliaryViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
@property (readonly, assign, nonatomic) CGRect onscreenFrame;
@property (readonly, assign, nonatomic) CGRect offscreenFrame;
@property (readonly, assign, nonatomic) CGRect onscreenFrameInHostView;
@property (readonly, assign, nonatomic) CGRect destRectForDraggerViewInHostView;
@property (readonly, assign, nonatomic) CGRect startRectForDraggerViewInHostView;

- (void) _hideAnimationFinished;

@end

@interface UIView (FLTouchableAuxilaryView)
- (void) auxiliaryViewControllerDragWillBegin:(FLAuxiliaryViewController*) controller;
- (void) auxiliaryViewController:(FLAuxiliaryViewController*) controller 
    didFinishDraggingWithResults:(FLViewDraggerResults) results;
@end