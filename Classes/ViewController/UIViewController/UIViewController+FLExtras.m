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

static void * const kDismissHandlerKey = (void*)&kDismissHandlerKey;
static void * const kBackButtonTitleKey = (void*)&kBackButtonTitleKey;
static void * const kViewControllerStackAnimationKey = (void*)&kViewControllerStackAnimationKey;

@implementation UIViewController (FLExtras)

- (NSString*) backButtonTitle {
    NSString* title = objc_getAssociatedObject(self, kBackButtonTitleKey);

	return FLStringIsEmpty(title) ? self.title : title;
}

- (void) setBackButtonTitle:(NSString *)backButtonTitle {
     objc_setAssociatedObject(self, kBackButtonTitleKey, backButtonTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    FLAssert(self.isViewLoaded, @"view is not loaded");

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
    FLAssert(self.isViewLoaded, @"view is not loaded");

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
    FLAssert(self.isViewLoaded, @"view not loaded");
    
    view.frame = [self frameForTopBarView:view];
    
    [self addViewWithTag:view tag:FLViewControllerTopToolBarTag];
    if([view respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)view) viewControllerTitleDidChange:self];
    }
}

- (void) setBottomBarView:(UIView*) view {
    FLAssert(self.isViewLoaded, @"view not loaded");

    view.frame = [self frameForBottomBarView:view];
    [self addViewWithTag:view tag:FLViewControllerBottomToolBarTag];
    if([view respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)view) viewControllerTitleDidChange:self];
    }    
}

- (CGRect) frameForTopBarView:(UIView*) view {
    CGRect frame = view.frame;
    frame.origin.y = self.statusBarInset;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (CGRect) frameForBottomBarView:(UIView*) view {
    CGRect frame = view.frame;
    frame.origin.y = FLRectGetBottom(self.view.bounds) - frame.size.height;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (void) willDismissViewControllerAnimated:(BOOL) animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

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
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    if(self.dismissHandler) {
        self.dismissHandler(self, animated);
    } else {
        [self willDismissViewControllerAnimated:animated];
    }
}

- (FLViewControllerDismissHandler) dismissHandler {
    return objc_getAssociatedObject(self, kDismissHandlerKey);
}

- (void) setDismissHandler:(FLViewControllerDismissHandler) handler {
    objc_setAssociatedObject(self, kDismissHandlerKey, handler, OBJC_ASSOCIATION_COPY);
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
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    FLAssertIsNotNil(viewController);
    FLAssert(viewController != self, @"can't present yourself in yourself");
      
    FLViewControllerTransitionAnimation* animation = viewController.transitionAnimation;
      
    if(!animation){
        animation = [[self class] defaultTransitionAnimation];
        viewController.transitionAnimation = animation;
    }
    FLAssertIsNotNil(animation);
    
    id<FLPresentationBehavior> behavior = viewController.presentationBehavior;
    
    if(!behavior) {
        behavior = [[viewController class] defaultPresentationBehavior];
        viewController.presentationBehavior = behavior;
    }

    FLAssertIsNotNil(behavior);
                  
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
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    if(!animated) {
        self.transitionAnimation = [UIViewController defaultTransitionAnimation]; 
    }

    [[UIApplication visibleViewController] presentChildViewController:self];
}

- (id<FLViewControllerTransitionAnimation>) transitionAnimation {
    return objc_getAssociatedObject(self, kViewControllerStackAnimationKey);
}

- (void) setTransitionAnimation:(id<FLViewControllerTransitionAnimation>) animation {
    objc_setAssociatedObject(self, kViewControllerStackAnimationKey, animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    UIActivityIndicatorView* spinner = FLReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style]);
    UIView* superview = self.view;
    spinner.frameOptimizedForLocation = FLRectCenterRectInRect(superview.bounds, spinner.frame);
    [spinner startAnimating];
    [superview addSubview:spinner];
    return spinner;
}
@end
