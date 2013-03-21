//
//  UIViewController+FLExtras.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewController.h"
#import <objc/runtime.h>

#import "FLToolbarView.h"
#import "UIViewController+FLPresentationBehavior.h"

#if OSX 
@implementation FLViewController
@end
#endif

#if IOS

@implementation FLViewController


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
		[self hideViewController:YES];
//        FLInvokeCallback(_dismissEvent, self);
	}
}

- (UIView*) viewByTag:(NSUInteger) tag {
    FLAssertWithComment(self.isViewLoaded, @"subview is not loaded");

    if(self.isViewLoaded) {
        for(UIView* subview in self.view.subviews) {
            if(subview.tag == tag)
            {
                return subview;
            }
        }
    }
    
    return nil;
}

- (void) addViewWithTag:(UIView*) subview tag:(NSUInteger) tag {
    FLAssertWithComment(self.isViewLoaded, @"subview is not loaded");

    if(self.isViewLoaded) {
        UIView* prev = [self viewByTag:tag];
        if(prev) {
            [prev removeFromSuperview];
        }
        subview.tag = tag;
        [self.view addSubview:subview];
    }
}


- (UIView*) topBarView {
    return [self viewByTag:FLViewControllerTopToolBarTag];
}

- (UIView*) bottomBarView {
    return [self viewByTag:FLViewControllerBottomToolBarTag];
}

- (void) setTopBarView:(UIView*) subview {
    FLAssertWithComment(self.isViewLoaded, @"subview not loaded");
    
    subview.frame = [self frameForTopBarView:subview];
    
    [self addViewWithTag:subview tag:FLViewControllerTopToolBarTag];
    if([subview respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)subview) viewControllerTitleDidChange:self];
    }
}

- (void) setBottomBarView:(UIView*) subview {
    FLAssertWithComment(self.isViewLoaded, @"subview not loaded");

    subview.frame = [self frameForBottomBarView:subview];
    [self addViewWithTag:subview tag:FLViewControllerBottomToolBarTag];
    if([subview respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
        [((id)subview) viewControllerTitleDidChange:self];
    }    
}

- (CGRect) frameForTopBarView:(UIView*) subview {
    CGRect frame = subview.frame;
    frame.origin.y = self.statusBarInset;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (CGRect) frameForBottomBarView:(UIView*) subview {
    CGRect frame = subview.frame;
    frame.origin.y = FLRectGetBottom(self.view.bounds) - frame.size.height;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (void) willHideViewController:(BOOL) animated {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    FLAutoreleaseObject(FLRetain(self));

    [[self presentationBehavior] willHideViewController:self
        fromParentViewController:self.parentViewController];
        
    id<FLViewControllerTransitionAnimation> animation = self.transitionAnimation;
    [animation beginHideAnimationForViewController:self 
                              parentViewController:self.parentViewController
                                     finishedBlock:^(id theViewController, id theParent){
                                         [[theViewController presentationBehavior] didDismissViewController:theViewController
                                            fromParentViewController:theParent];
                                         [theViewController viewControllerDidDisappear];
                                     }];
}

- (void) hideViewController:(BOOL) animated {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    if(self.dismissHandler) {
        self.dismissHandler(self, animated);
    } else {
        [self willHideViewController:animated];
    }
}

- (void) viewControllerDidAppear {
}

- (void) viewControllerDidDisappear {
}

- (void) viewControllerWillAppear {
}

- (void) viewControllerWillDisappear {

}

// the animation is saved and used for dismissal
// if the frame of the viewController is zero, the frame is set to the parents views
// bounds, otherwise the frame is preserved. 
- (void) showViewController:(BOOL) animated
       inHostViewController:(UIViewController*) hostViewController {

    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    FLAssertIsNotNil(self);
    FLAssertWithComment(self != hostViewController, @"can't present yourself in yourself");
      
    FLViewControllerTransitionAnimation* animation = self.transitionAnimation;
      
    if(!animation){
        animation = [[hostViewController class] defaultTransitionAnimation];
        self.transitionAnimation = animation;
    }
    FLAssertIsNotNil(animation);
    
    id<FLPresentationBehavior> behavior = self.presentationBehavior;
    
    if(!behavior) {
        behavior = [[self class] defaultPresentationBehavior];
        self.presentationBehavior = behavior;
    }

    FLAssertIsNotNil(behavior);
                  
    if(CGRectEqualToRect(self.view.frame, CGRectZero)) {
        self.view.frame = hostViewController.view.bounds;
    }
    
    
    CGRect frame = self.view.frame;
    [behavior willPresentViewController:self inParentViewController:hostViewController];
    self.view.frame = frame; // please respect my frame
             
    [self viewControllerWillAppear];
                
    [animation beginShowAnimationForViewController:self 
        parentViewController:hostViewController 
        finishedBlock:^(id theViewController, id theParent) {
                [theViewController viewControllerDidAppear];
                [[theViewController presentationBehavior] didPresentViewController:theViewController 
                                                            inParentViewController:theParent];
            }];
}

- (void) showViewController:(BOOL) animated {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    if(!animated) {
        self.transitionAnimation = [UIViewController defaultTransitionAnimation]; 
    }

    if(self.parentViewController) {
        [self showViewController:animated inHostViewController:self.parentViewController];
    }
    else {
        [[UIApplication visibleViewController] showChildViewController:self];
    }
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

- (void) hideViewControllerWithSender:(id) sender {
    [self hideViewController:YES];
}

@end

@implementation UIViewController (ProgressAdditions)
- (UIActivityIndicatorView*) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    UIActivityIndicatorView* spinner = FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style]);
    UIView* superview = self.view;
    spinner.frameOptimizedForLocation = FLRectCenterRectInRect(superview.bounds, spinner.frame);
    [spinner startAnimating];
    [superview addSubview:spinner];
    return spinner;
}
@end
#endif

//@implementation UIViewController (FLNibLoading)
//
//- (NSString*) defaultNibName {
//#if OSX
//    return [NSString stringWithFormat:@"%@-OSX", NSStringFromClass([self class])];
//#else 
//    return [NSString stringWithFormat:@"%@-iOS", NSStringFromClass([self class])];
//#endif    
//}
//
//- (id) initWithDefaultNibName {
//    return [self initWithNibName:self.defaultNibName bundle:nil];
//}
//
//- (id) initWithDefaultNibName:(NSBundle *)nibBundleOrNil {
//    return [self initWithNibName:self.defaultNibName bundle:nibBundleOrNil];
//}
//
//
//@end
