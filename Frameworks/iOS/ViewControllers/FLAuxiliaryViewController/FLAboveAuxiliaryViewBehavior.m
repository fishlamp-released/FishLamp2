//
//  FLFloatingAuxiliaryViewBehavior.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "_FLAuxiliaryViewController.h"
#import "FLAboveAuxiliaryViewBehavior.h"

@implementation FLAboveAuxiliaryViewBehavior

FLSynthesizeSingleton(FLAboveAuxiliaryViewBehavior);

- (BOOL) handleInternalTouches:(NSSet*) touches event:(UIEvent*) event viewController:(FLAuxiliaryViewController*) viewController {
    return YES;
}

- (UIViewController*) parentControllerForAuxiliaryViewController:(FLAuxiliaryViewController*) viewController {
    return viewController.parentViewController;
}

- (void) addContainerViewToParentViewController:(FLAuxiliaryViewController*) viewController {
    [viewController.parentViewController addChildViewController:viewController.viewController];
    [viewController.parentViewController.view addSubview:viewController.containerView];
    [viewController.dragController addDragResponder:viewController.containerView];
    
    viewController.containerView.layer.shadowColor = [UIColor grayColor].CGColor;
    viewController.containerView.layer.shadowOpacity = .6;
    viewController.containerView.layer.shadowRadius = 20.0;
    viewController.containerView.layer.shadowOffset = CGSizeMake(0,3);
    viewController.containerView.clipsToBounds = NO;
}

- (void) showViewControllerAnimated:(BOOL) animated viewController:(FLAuxiliaryViewController*) viewController {
    CGPoint delta = FLPointSubtractPointFromPoint([viewController onscreenFrame].origin, viewController.containerView.frame.origin);
    [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:nil];
}

- (void) hideViewController:(BOOL) animated viewController:(FLAuxiliaryViewController*) viewController {
    if(viewController.viewController) {
        CGPoint delta = FLPointSubtractPointFromPoint([viewController offscreenFrame].origin, viewController.containerView.frame.origin);
        [viewController.dragController moveDragRespondersByAmount:delta animationDuration:0.3 animationFinished:^{ [viewController _hideAnimationFinished]; }];
    }
} 

- (void) didFinishDraggingWithResults:(FLViewDraggerResults) results viewController:(FLAuxiliaryViewController*) viewController {
    
    TODO(why is this commented out?)
    
    
    //    [self performBlockWithDelay:1.0f block:
    //        ^{
    //            if(!viewController.auxiliaryViewIsOpen)
    //            {
    //                [viewController hideViewController:NO];
    //            }
    //        }];
}

- (CGRect) initialFrameForContainerView:(FLAuxiliaryViewController*) viewController {
    return [viewController offscreenFrame];
}

- (void) didAddTouchableView:(FLAuxiliaryViewController*) viewController {
    [viewController.dragController addDragResponder:viewController.dragController.touchableView];
    
    for(id secondary in viewController.dragController.secondaryTouchableViews) {
        [viewController.dragController addDragResponder:secondary];
    }
}

@end
