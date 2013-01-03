//
//  UIViewController+OSX.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "UIViewController+OSX.h"
#import "FLObjcRuntime.h"
#import "UIView+OSX_Internal.h"

@implementation NSViewController (UIKit)

FLSynthesizeAssociatedProperty(assign_nonatomic, parentViewController, setParentViewController, NSViewController*);
FLSynthesizeAssociatedProperty(retain_nonatomic, childViewControllers, setChildViewControllers, NSArray*);
FLSynthesizeAssociatedProperty(retain_nonatomic, viewIsLoadedNumber, setViewIsLoadedNumber, NSNumber*);

#pragma mark -- child view controllers

- (void) addChildViewController:(NSViewController*) viewController {
    
    NSMutableArray* children = (NSMutableArray*) self.childViewControllers;
    if(!children) {
        children = [NSMutableArray array];
        self.childViewControllers = children;
    }
    
    [viewController removeFromParentViewController];
    
    [viewController willMoveToParentViewController:self];
    [children addObject:viewController];
    viewController.parentViewController = self;
   [self didMoveToParentViewController:viewController];
}

- (void) removeViewController:(UIViewController*) viewController {
    if(viewController.parentViewController == self) {
        
        
        [viewController willMoveToParentViewController:nil];
        
        NSMutableArray* children = (NSMutableArray*) self.childViewControllers;
        [children removeObject:viewController];

        viewController.parentViewController = nil;
        [self didMoveToParentViewController:nil];
    }
}

- (void) removeFromParentViewController {
    if(self.parentViewController) {
        [self.parentViewController removeViewController:self];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
}

#pragma mark -- view layout

- (void) viewDidLayoutSubviews {
}

- (void) viewWillLayoutSubviews {
}


#pragma mark -- view appear/disappear

- (void) viewWillDisappear:(BOOL) animated {
}

- (void) viewDidDisappear:(BOOL) animated {
}

- (void) viewWillAppear:(BOOL) animated {
}

- (void) viewDidAppear:(BOOL) animated {
}

#pragma mark -- loading

- (BOOL) isViewLoaded {
    NSNumber* loaded = self.viewIsLoadedNumber;
    return loaded && [loaded boolValue];
}

- (void) setViewLoaded:(BOOL) viewLoaded {
   self.viewIsLoadedNumber = [NSNumber numberWithBool:viewLoaded];
}

- (void) viewDidLoad {
}

- (void) viewDidUnload {
}

- (void) viewWillUnload {
}

- (void) didLoadViewForCompatibility:(NSView*) view {
}

- (void) didUnloadViewForCompatibility:(NSView*) view {
}        

- (void) unloadLoadedView {
    if(self.isViewLoaded) { 
        [self viewWillUnload];
        UIView* theView = FLRetainWithAutorelease(self.view);
        theView.viewController = nil;
        self.viewLoaded = NO;
        [self setView:nil];
        [self viewDidUnload];
        [self didUnloadViewForCompatibility:theView];
    }
}

- (void)didReceiveMemoryWarning {

}

- (void) setViewLoaded {
    if(!self.isViewLoaded){
        UIView* theView = self.view;
        if(theView) {
            theView.viewController = self;
            self.viewLoaded = YES;
            [self viewDidLoad];
            [self didLoadViewForCompatibility:theView];
        }
    }
}

#pragma mark -- transitions

- (UIViewController*) presentedViewController {
    return nil;
}

- (UIViewController*) presentingViewController {
    return nil;
}

- (BOOL)isBeingPresented {
    return NO;
}

- (BOOL)isBeingDismissed {
    return NO;
}

- (BOOL)isMovingToParentViewController {
    return NO;
}

- (BOOL)isMovingFromParentViewController {
    return NO;
}

- (void)transitionFromViewController:(UIViewController *)fromViewController
                    toViewController:(UIViewController *)toViewController
                            duration:(NSTimeInterval)duration
                             options:(UIViewAnimationOptions)options
                          animations:(void (^)(void))animations
                          completion:(void (^)(BOOL finished))completion {
    
}

- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated {

}

- (void)endAppearanceTransition {
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion {
    
}

- (void)hideViewController:(BOOL)flag
                           completion: (void (^)(void))completion {
    
}



#pragma mark -- swizzled for compatibility

- (void) compatibleSetView:(NSView*) aView {
    
    [self unloadLoadedView];
    [self compatibleSetView:aView];
    [self setViewLoaded];
}

//- (void) compatibleLoadView {
//    [self unloadLoadedView];
//    [self compatibleLoadView];
//    [self setViewLoaded];
//}

+ (void) initUIKitCompatibility {
//    FLSelectorSwizzle([UIViewController class], @selector(compatibleLoadView), @selector(loadView));
    FLSelectorSwizzle([UIViewController class], @selector(compatibleSetView:), @selector(setView:));
}

@end

#endif


