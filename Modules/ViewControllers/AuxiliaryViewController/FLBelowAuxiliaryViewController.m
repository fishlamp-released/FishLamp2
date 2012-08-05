//
//  FLRevealedAuxiliaryViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLBelowAuxiliaryViewController.h"
#import "_FLAuxiliaryViewController.h"

#define kBelowBuffer 2.0f

@implementation FLBelowAuxiliaryViewBehavior

FLSynthesizeSingleton(FLBelowAuxiliaryViewBehavior);

- (UIViewController*) parentControllerForAuxiliaryViewController:(FLAuxiliaryViewController*) viewController {
    FLAssertIsNotNil(viewController);
    
    return viewController.parentViewController.parentViewController;
}

- (void) addContainerViewToParentViewController:(FLAuxiliaryViewController*) childController {

    FLAssertIsNotNil(childController);

// This is a little confusing - using child/parent/grandparent metaphor.

    UIViewController* parent = childController.parentViewController;
    FLAssertIsNotNil(parent);

// parent's parent    
    UIViewController* grandParent = parent.parentViewController;
    FLAssertIsNotNil(grandParent);

// we're inserting child below parent, e.g. IN grandparent
    [grandParent addChildViewController:childController.viewController];

// insert view below parent view in grandParent's view list
    [grandParent.view insertSubview:childController.containerView belowSubview:parent.view];
    
// because we're now below parent, make parent hip to our touches
    [childController.dragController addDragResponder:parent.view];
}

- (CGRect) scrollDestinationRectForBelowStyle:(FLAuxiliaryViewController*) viewController {

    FLAssertIsNotNil(viewController);

    CGRect onScreenFrame = [viewController onscreenFrame];
    UIView* view = viewController.parentViewController.view;
    CGRect frame; 
    switch(viewController.revealSide) {
        case FLAuxiliaryViewControllerPinnedSideRight:
            frame = FLRectSetLeft(view.frame, view.superview.bounds.origin.x - onScreenFrame.size.width - kBelowBuffer);    
            break;
            
        case FLAuxiliaryViewControllerPinnedSideLeft:
            frame = FLRectSetLeft(view.frame, view.superview.bounds.origin.x + onScreenFrame.size.width + kBelowBuffer);    
            break;
            
        case FLAuxiliaryViewControllerPinnedSideBottom:
            frame = FLRectSetTop(view.frame, view.superview.bounds.origin.y - onScreenFrame.size.height - kBelowBuffer);    
            break;
            
        case FLAuxiliaryViewControllerPinnedSideTop:
            frame = FLRectSetTop(view.frame, view.superview.bounds.origin.y + onScreenFrame.size.height + kBelowBuffer);    
            break;
    }            
    
    return frame;
}

- (void) showViewControllerAnimated:(BOOL) animated viewController:(FLAuxiliaryViewController*) viewController {

    FLAssertIsNotNil(viewController);

    if(viewController.revealSide == FLAuxiliaryViewControllerPinnedSideBottom) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    CGPoint delta = FLPointSubtractPointFromPoint([self scrollDestinationRectForBelowStyle:viewController].origin, viewController.parentViewController.view.frame.origin);
    
    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:nil];
}

- (void) hideViewControllerAnimated:(BOOL) animated viewController:(FLAuxiliaryViewController*) viewController {

    FLAssertIsNotNil(viewController);

    if(viewController.revealSide == FLAuxiliaryViewControllerPinnedSideBottom) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    
    CGPoint delta = FLPointSubtractPointFromPoint(viewController.parentViewController.view.superview.bounds.origin, viewController.parentViewController.view.frame.origin);
    
    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:^{ [viewController _hideAnimationFinished]; }];
} 

- (void) didFinishDraggingWithResults:(FLViewDraggerResults) results 
                       viewController:(FLAuxiliaryViewController*) viewController {    

    FLAssertIsNotNil(viewController);

    CGRect frame = [viewController.dragController touchableViewFrameInHostView];
    
    if( results.userDidTouchView &&
       results.lastTouchInTouchableView &&
       !results.didDragView) {
        if(CGRectEqualToRect(frame, [viewController startRectForDraggerViewInHostView])) {
            [viewController showViewControllerAnimated:YES];
        }
        else {
            [viewController hideViewControllerAnimated:YES];
        }
        
    }
    else
    {
        if(CGRectEqualToRect(frame, [viewController startRectForDraggerViewInHostView])) {
            [viewController hideViewControllerAnimated:NO];
        }
        else {
            if(viewController.revealSide == FLAuxiliaryViewControllerPinnedSideBottom) {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            }
        }
    }
}

- (CGRect) initialFrameForContainerView:(FLAuxiliaryViewController*) viewController {

    FLAssertIsNotNil(viewController);

    return [viewController onscreenFrame];
}

- (BOOL) handleInternalTouches:(NSSet*) touches 
                         event:(UIEvent*) event 
                viewController:(FLAuxiliaryViewController*) viewController {

    FLAssertIsNotNil(viewController);

    return YES;
}

- (void) didAddTouchableView:(FLAuxiliaryViewController*) viewController {
}

@end
