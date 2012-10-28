//
//  UIViewController+FLExtras.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "UIViewController+FLExtras.h"
#import <objc/runtime.h>

#import "FLToolbarView.h"
#import "UIViewController+FLPresentationBehavior.h"

@implementation UIViewController (FLExtras)

FLSynthesizeAssociatedProperty(copy_nonatomic, dismissHandler, setDismissHandler, FLViewControllerDismissHandler);
FLSynthesizeAssociatedProperty(retain_nonatomic, _backButtonTitle, setBackButtonTitle, NSString*);
FLSynthesizeAssociatedProperty(retain_nonatomic, transitionAnimation, setTransitionAnimation, id<FLViewControllerTransitionAnimation>);

- (NSString*) backButtonTitle {
    NSString* title = self._backButtonTitle;

	return FLStringIsEmpty(title) ? self.title : title;
}

- (BOOL) backButtonWillDismissViewController {
	return YES;
}

- (void) respondToBackButtonPress:(id) sender {
	if([self backButtonWillDismissViewController]) {
		[self dismissViewControllerAnimated:YES];
//        FLInvokeCallback(_dismissEvent, self);
	}
}

- (UIView*) viewByTag:(NSUInteger) tag {
    FLAssert_v(self.isViewLoaded, @"view is not loaded");

    if(self.isViewLoaded) {
        for(UIView* view in self.view.subviews) {
            if(view.tag == tag)
            {
                return view;
            }
        }
    }
    
    return nil;
}

- (void) addViewWithTag:(UIView*) view tag:(NSUInteger) tag {
    FLAssert_v(self.isViewLoaded, @"view is not loaded");

    if(self.isViewLoaded) {
        UIView* prev = [self viewByTag:tag];
        if(prev) {
            [prev removeFromSuperview];
        }
        view.tag = tag;
        [self.view addSubview:view];
    }
}

- (UIView*) topBarView {
    return [self viewByTag:FLViewControllerTopToolBarTag];
}

- (UIView*) bottomBarView {
    return [self viewByTag:FLViewControllerBottomToolBarTag];
}

- (void) setTopBarView:(UIView*) view {
    FLAssert_v(self.isViewLoaded, @"view not loaded");
    
    view.frame = [self frameForTopBarView:view];
    
    [self addViewWithTag:view tag:FLViewControllerTopToolBarTag];
    if([view respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)view) viewControllerTitleDidChange:self];
    }
}

- (void) setBottomBarView:(UIView*) view {
    FLAssert_v(self.isViewLoaded, @"view not loaded");

    view.frame = [self frameForBottomBarView:view];
    [self addViewWithTag:view tag:FLViewControllerBottomToolBarTag];
    if([view respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)view) viewControllerTitleDidChange:self];
    }    
}

- (FLRect) frameForTopBarView:(UIView*) view {
    FLRect frame = view.frame;
    frame.origin.y = self.statusBarInset;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (FLRect) frameForBottomBarView:(UIView*) view {
    FLRect frame = view.frame;
    frame.origin.y = FLRectGetBottom(self.view.bounds) - frame.size.height;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (void) willDismissViewControllerAnimated:(BOOL) animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    FLAutorelease(FLReturnRetained(self));

    [[self presentationBehavior] willDismissViewController:self 
        fromParentViewController:self.parentViewController];
        
    id<FLViewControllerTransitionAnimation> animation = self.transitionAnimation;
    [animation beginHideAnimationForViewController:self 
                              parentViewController:self.parentViewController
                                     finishedBlock:^(id theViewController, id theParent){
                                         [[theViewController presentationBehavior] didDismissViewController:theViewController
                                            fromParentViewController:theParent];
                                         [theViewController wasDismissedFromParentViewController];
                                     }];
}

- (void) dismissViewControllerAnimated:(BOOL) animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    if(self.dismissHandler) {
        self.dismissHandler(self, animated);
    } else {
        [self willDismissViewControllerAnimated:animated];
    }
}

- (void) wasPresentedInParentViewController {
}

- (void) wasDismissedFromParentViewController {
}

- (void) willPresentInViewController {
    [self applyThemeIfNeeded];
}

// the animation is saved and used for dismissal
// if the frame of the viewController is zero, the frame is set to the parents views
// bounds, otherwise the frame is preserved. 
- (void) presentChildViewController:(UIViewController*) viewController {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    FLAssertIsNotNil_(viewController);
    FLAssert_v(viewController != self, @"can't present yourself in yourself");
      
    FLViewControllerTransitionAnimation* animation = viewController.transitionAnimation;
      
    if(!animation){
        animation = [[self class] defaultTransitionAnimation];
        viewController.transitionAnimation = animation;
    }
    FLAssertIsNotNil_(animation);
    
    id<FLPresentationBehavior> behavior = viewController.presentationBehavior;
    
    if(!behavior) {
        behavior = [[viewController class] defaultPresentationBehavior];
        viewController.presentationBehavior = behavior;
    }

    FLAssertIsNotNil_(behavior);
                  
    if(CGRectEqualToRect(viewController.view.frame, CGRectZero)) {
        viewController.view.frame = self.view.bounds;
    }
    
    
    FLRect frame = viewController.view.frame;
    [behavior willPresentViewController:viewController inParentViewController:self];
    viewController.view.frame = frame; // please respect my frame
             
    [viewController willPresentInViewController];
                
    [animation beginShowAnimationForViewController:viewController 
        parentViewController:self 
        finishedBlock:^(id theViewController, id theParent) {
                [theViewController wasPresentedInParentViewController];
                [[theViewController presentationBehavior] didPresentViewController:theViewController 
                                                            inParentViewController:theParent];
            }];
}

- (void) presentViewControllerAnimated:(BOOL) animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    if(!animated) {
        self.transitionAnimation = [UIViewController defaultTransitionAnimation]; 
    }

    [[UIApplication visibleViewController] presentChildViewController:self];
}

+ (id<FLViewControllerTransitionAnimation>) defaultTransitionAnimation {
    return [FLDefaultViewControllerAnimation viewControllerTransitionAnimation];
}

- (UINavigationController*) rootNavigationController  {
    return self.navigationController;
}

- (UIViewController*) visibleViewController {
    return self.rootNavigationController ? [self.rootNavigationController visibleViewController] : self;
}

- (void) dismissViewControllerWithSender:(id) sender {
    [self dismissViewControllerAnimated:YES];
}

@end



@implementation UIViewController (ProgressAdditions)
- (UIActivityIndicatorView*) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    UIActivityIndicatorView* spinner = FLReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style]);
    UIView* superview = self.view;
    spinner.frameOptimizedForLocation = FLRectCenterRectInRect(superview.bounds, spinner.frame);
    [spinner startAnimating];
    [superview addSubview:spinner];
    return spinner;
}
@end
