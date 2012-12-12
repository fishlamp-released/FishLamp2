//
//  SDKViewController+FLExtras.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "SDKViewController+FLAdditions.h"
#import <objc/runtime.h>

#import "FLToolbarView.h"
#import "SDKViewController+FLPresentationBehavior.h"

@implementation SDKViewController (FLExtras)

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

- (SDKView*) viewByTag:(NSUInteger) tag {
    FLAssert_v(self.isViewLoaded, @"subview is not loaded");

    if(self.isViewLoaded) {
        for(SDKView* subview in self.view.subviews) {
            if(subview.tag == tag)
            {
                return subview;
            }
        }
    }
    
    return nil;
}

#if IOS
- (void) addViewWithTag:(SDKView*) subview tag:(NSUInteger) tag {
    FLAssert_v(self.isViewLoaded, @"subview is not loaded");

    if(self.isViewLoaded) {
        SDKView* prev = [self viewByTag:tag];
        if(prev) {
            [prev removeFromSuperview];
        }
        subview.tag = tag;
        [self.view addSubview:subview];
    }
}


- (SDKView*) topBarView {
    return [self viewByTag:FLViewControllerTopToolBarTag];
}

- (SDKView*) bottomBarView {
    return [self viewByTag:FLViewControllerBottomToolBarTag];
}

- (void) setTopBarView:(SDKView*) subview {
    FLAssert_v(self.isViewLoaded, @"subview not loaded");
    
    subview.frame = [self frameForTopBarView:subview];
    
    [self addViewWithTag:subview tag:FLViewControllerTopToolBarTag];
    if([subview respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)subview) viewControllerTitleDidChange:self];
    }
}

- (void) setBottomBarView:(SDKView*) subview {
    FLAssert_v(self.isViewLoaded, @"subview not loaded");

    subview.frame = [self frameForBottomBarView:subview];
    [self addViewWithTag:subview tag:FLViewControllerBottomToolBarTag];
    if([subview respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)subview) viewControllerTitleDidChange:self];
    }    
}

- (CGRect) frameForTopBarView:(SDKView*) subview {
    CGRect frame = subview.frame;
    frame.origin.y = self.statusBarInset;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (CGRect) frameForBottomBarView:(SDKView*) subview {
    CGRect frame = subview.frame;
    frame.origin.y = FLRectGetBottom(self.view.bounds) - frame.size.height;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}
#endif

- (void) willDismissViewControllerAnimated:(BOOL) animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    FLAutorelease(FLRetain(self));

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
- (void) presentChildViewController:(SDKViewController*) viewController {
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
    
    
    CGRect frame = viewController.view.frame;
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
        self.transitionAnimation = [SDKViewController defaultTransitionAnimation]; 
    }

    FLIOS([[UIApplication visibleViewController] presentChildViewController:self]);
}

+ (id<FLViewControllerTransitionAnimation>) defaultTransitionAnimation {
    return [FLDefaultViewControllerAnimation viewControllerTransitionAnimation];
}

#if IOS
- (UINavigationController*) rootNavigationController  {
    return self.navigationController;
}

#endif 

- (SDKViewController*) visibleViewController {
    FLIOS(
        return self.rootNavigationController ? [self.rootNavigationController visibleViewController] : self
    );
}

- (void) dismissViewControllerWithSender:(id) sender {
    [self dismissViewControllerAnimated:YES];
}


@end

#if IOS


@implementation SDKViewController (ProgressAdditions)
- (UIActivityIndicatorView*) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    UIActivityIndicatorView* spinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style]);
    SDKView* superview = self.view;
    spinner.frameOptimizedForLocation = FLRectCenterRectInRect(superview.bounds, spinner.frame);
    [spinner startAnimating];
    [superview addSubview:spinner];
    return spinner;
}
@end
#endif

@implementation SDKViewController (FLNibLoading)

- (NSString*) defaultNibName {
#if OSX
    return [NSString stringWithFormat:@"%@-OSX", NSStringFromClass([self class])];
#else 
    return [NSString stringWithFormat:@"%@-iOS", NSStringFromClass([self class])];
#endif    
}

- (id) initWithDefaultNibName {
    return [self initWithNibName:self.defaultNibName bundle:nil];
}

- (id) initWithDefaultNibName:(NSBundle *)nibBundleOrNil {
    return [self initWithNibName:self.defaultNibName bundle:nibBundleOrNil];
}


@end